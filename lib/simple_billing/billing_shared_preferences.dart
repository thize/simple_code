part of billing;

class _BillingSharedPrefs {
  static final String _prefix = 'sb_';
  static SharedPreferences sP;

  static Future<void> setPurchases(Set<String> purchases) async {
    sP = await getInstance();
    await sP.setStringList('${_prefix}purchases', purchases.toList());
  }

  static Future<Set<String>> getPurchases() async {
    sP = await getInstance();
    return sP.getStringList('${_prefix}purchases')?.toSet() ?? {};
  }

  static Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }
}
