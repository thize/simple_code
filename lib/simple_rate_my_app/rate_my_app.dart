part of rate_my_app;

class SimpleRateMyApp {
  static int daysElapsed;
  static int launchesElapsed;
  static int _minDays;
  static int _minLaunches;
  static int _remindDays;
  static int _remindLaunches;
  static bool _dontShowMore = false;
  static void Function() _onShowIOS;
  static void Function() _onShowAndroid;
  static bool Function() _ruleToShow;
  static Future<void> init({
    int minDays = 7,
    int minLaunches = 10,
    int remindDays = 7,
    int remindLaunches = 10,
    void Function() onShowIOS = openIosRateDialog,
    void Function() onShowAndroid,
    bool Function() ruleToShow,
  }) async {
    _ruleToShow = ruleToShow ?? _defaultRuleToShow;
    _dontShowMore = await _RateMyAppSharedPrefs.getDontShowMore();
    _onShowIOS = onShowIOS;
    _onShowAndroid = onShowAndroid;
    _minDays = minDays;
    _minLaunches = minLaunches;
    _remindDays = remindDays;
    _remindLaunches = remindLaunches;
    daysElapsed = await _RateMyAppSharedPrefs.getDays();
    launchesElapsed = await _RateMyAppSharedPrefs.getLaunchers() + 1;
    _RateMyAppSharedPrefs.setLaunchers(launchesElapsed);
  }

  static Future<void> openStore() async => await AppReview.storeListing;

  static void changeRuleToShow(bool Function() newRuleToShow) {
    _ruleToShow = newRuleToShow;
  }

  static bool get isToShow {
    return _ruleToShow();
  }

  static bool _defaultRuleToShow() {
    return (daysElapsed >= _minDays && daysElapsed % _remindDays == 0) ||
        (launchesElapsed >= _minLaunches &&
            launchesElapsed % _remindLaunches == 0);
  }

  static void openIosRateDialog() {
    if (Platform.isIOS) {
      AppReview.requestReview.then((onValue) {
        print(onValue);
      });
    }
  }

  static void show({bool force = false}) {
    if ((isToShow || force) && !_dontShowMore) {
      if (Platform.isIOS) {
        _onShowIOS();
      } else if (_onShowAndroid != null) {
        _onShowAndroid();
      }
    }
  }

  static Future<void> dontShowMore() async {
    _dontShowMore = true;
    await _RateMyAppSharedPrefs.setDontShowMore(true);
  }

  static bool get dontShowMoreValue => _dontShowMore;

  static Future<void> reset() async {
    daysElapsed = 1;
    launchesElapsed = 1;
    await _RateMyAppSharedPrefs.updateDateTime();
    await _RateMyAppSharedPrefs.setDays(daysElapsed);
    await _RateMyAppSharedPrefs.setLaunchers(launchesElapsed);
    await _RateMyAppSharedPrefs.setDontShowMore(false);
  }
}
