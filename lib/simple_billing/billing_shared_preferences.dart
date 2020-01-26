part of billing;

class _BillingSharedPrefs {
  static SharedPreferences sP;

  static Future<void> updatePurchases(Set<String> purchases) async {
    sP = await getInstance();
    await sP.setStringList('purchases', purchases.toList());
  }

  static Future<Set<String>> getPurchases() async {
    sP = await getInstance();
    return sP.getStringList('purchases')?.toSet() ?? {};
  }

  static Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }
}
