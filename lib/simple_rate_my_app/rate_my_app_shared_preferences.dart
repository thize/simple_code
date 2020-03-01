part of simple_code;

class _RateMyAppSharedPrefs {
  static final String _prefix = 'srma_';
  static SharedPreferences sP;

  static Future<int> getDays() async {
    sP = await getInstance();
    var now = DateTime.now().toString();
    var days = sP.getInt('${_prefix}days') ?? 0;
    var date = sP.getString('${_prefix}date') ??
        DateTime.now().subtract(Duration(days: 2)).toString();
    var diference = DateTime.parse(now).difference(DateTime.parse(date)).inDays;
    if (diference > 0) {
      days++;
      setDays(days);
      updateDateTime();
    }
    return days;
  }

  static Future<void> setDays(int newDays) async {
    sP = await getInstance();
    return sP.setInt('${_prefix}days', newDays);
  }

  static Future<void> updateDateTime() async {
    sP = await getInstance();
    return sP.setString('${_prefix}date', DateTime.now().toString());
  }

  static Future<int> getLaunchers() async {
    sP = await getInstance();
    return sP.getInt('${_prefix}launchers') ?? 0;
  }

  static Future<void> setLaunchers(int newLaunchers) async {
    sP = await getInstance();
    return sP.setInt('${_prefix}launchers', newLaunchers);
  }

  static Future<bool> getDontShowMore() async {
    sP = await getInstance();
    bool value = sP.getBool('${_prefix}dontShowMore');
    if (value == null) setDontShowMore(false);
    return value ?? false;
  }

  static Future<void> setDontShowMore(bool newValue) async {
    sP = await getInstance();
    return sP.setBool('${_prefix}dontShowMore', newValue);
  }

  static Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }
}
