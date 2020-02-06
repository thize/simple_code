part of billing;

/// [PROGUARD LINES]
/*
#In app Purchase
-keep class com.amazon.** {*;}
-keep class com.dooboolab.** { *; }
-keep class com.android.vending.billing.**
-dontwarn com.amazon.**
-keepattributes *Annotation*
*/

class SimpleBilling {
  static StreamSubscription _purchaseUpdatedSubscription;
  static StreamSubscription _purchaseErrorSubscription;
  static StreamSubscription _conectionSubscription;
  static Widget _popUpWidget;
  static List<IAPItem> products;
  static Set<String> purchasesId = {};
  static BuildContext _context;
  static void Function(String roductId, bool isNewPurchase) _onPurchaseUpdated;
  static bool _openedPopUp = false;
  static bool _offline;
  static List<String> _productsId;

  static Future<void> init({
    List<String> productsId,
    bool offline = true,
    Widget popUpWidget,
    void Function(String productId, bool isNewPurchase) onPurchaseUpdated,
  }) async {
    _productsId = productsId ?? _productsId;
    if (_productsId == null) throw 'initBilling with productsId';
    _offline = offline ?? _offline;
    _onPurchaseUpdated = onPurchaseUpdated ?? _onPurchaseUpdated;
    _popUpWidget = popUpWidget ?? _popUpWidget;
    await FlutterInappPurchase.instance.initConnection;
    try {
      products = await FlutterInappPurchase.instance.getProducts(productsId);
    } catch (e) {
      products = [];
    }
    try {
      await FlutterInappPurchase.instance.consumeAllItems;
    } catch (e) {
      print('');
    }
    _conectionSubscription =
        FlutterInappPurchase.connectionUpdated.listen((connected) {
      _closePopUp();
    });

    _purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((productItem) {
      _closePopUp();
      _onPurchaseUpdated(productItem.productId, true);
      restorePurchases();
    });

    _purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen((purchaseError) {
      _closePopUp();
    });
    await restorePurchases();
  }

  static Future<void> buyProduct(String productId,
      {BuildContext context}) async {
    try {
      _openPopUp(context);
      await FlutterInappPurchase.instance.requestPurchase(productId);
    } catch (e) {
      print('$productId = $e');
    }
  }

  static Future<void> restorePurchases() async {
    List<PurchasedItem> purchaseHistory;
    try {
      purchaseHistory =
          await FlutterInappPurchase.instance.getPurchaseHistory();
    } catch (e) {
      print('Offline');
    }
    purchasesId.addAll(
        (purchaseHistory)?.map((product) => product.productId)?.toSet() ?? {});
    if (_offline ?? true) {
      if (purchasesId != null && purchasesId.isNotEmpty) {
        await _BillingSharedPrefs.setPurchases(purchasesId);
      } else {
        purchasesId = {};
      }
      purchasesId.addAll(await _BillingSharedPrefs.getPurchases());
    }
    purchasesId.forEach((String purchase) {
      _onPurchaseUpdated(purchase, false);
    });
  }

  static String getPriceById(String productId) {
    return getProductById(productId)?.localizedPrice;
  }

  static IAPItem getProductById(String productId) {
    try {
      IAPItem item =
          products?.firstWhere((product) => product?.productId == productId);
      return item;
    } catch (e) {
      return null;
    }
  }

  static bool checkPurchase(String productId) {
    return purchasesId?.contains(productId) ?? false;
  }

  static Set<String> checkPurchases(List<String> productId) {
    Set<String> purchases = {};
    for (var purchaseId in purchasesId ?? {}) {
      if (productId?.contains(purchaseId) ?? false) {
        purchases.add(purchaseId);
      }
    }
    return purchases;
  }

  static Widget get defaultPopUpWidget => _DefaultBillingPopUp();

  static void setPopUp(Widget widget) {
    _popUpWidget = widget;
  }

  static void _openPopUp(BuildContext context) {
    if (!_openedPopUp && _popUpWidget != null) {
      if (context == null) {
        throw 'INVALID: _popUpWidget != null && context != null';
      }
      _context = context;
      _openedPopUp = true;
      showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext context, Animation animation,
                Animation secondaryAnimation) =>
            _popUpWidget,
        barrierDismissible: false,
        useRootNavigator: false,
        transitionDuration: Duration(milliseconds: 200),
      );
    }
  }

  static void _closePopUp() {
    if (_openedPopUp && _context != null) {
      _openedPopUp = false;
      Navigator.pop(_context);
      _context = null;
    }
  }

  static void setFakePurchases(Set<String> purchases) async {
    purchasesId.addAll(purchases);
    await _BillingSharedPrefs.setPurchases(purchasesId);
    purchasesId.forEach((element) {
      _onPurchaseUpdated(element, false);
    });
  }

  static Future<void> dispose() async {
    await FlutterInappPurchase.instance.endConnection;
    if (_conectionSubscription != null) {
      _conectionSubscription.cancel();
      _conectionSubscription = null;
    }
    if (_purchaseUpdatedSubscription != null) {
      _purchaseUpdatedSubscription.cancel();
      _purchaseUpdatedSubscription = null;
    }
    if (_purchaseErrorSubscription != null) {
      _purchaseErrorSubscription.cancel();
      _purchaseErrorSubscription = null;
    }
  }
}
