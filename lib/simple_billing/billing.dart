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
  static List<IAPItem> _products;
  static Set<String> purchasesId;
  static BuildContext _context;
  static void Function(PurchasedItem, bool) _onPurchaseUpdated;
  static bool _openedPopUp = false;
  static bool _offline;

  static void initBilling({
    @required List<String> products,
    bool offline = true,
    Widget popUpWidget,
    void Function(PurchasedItem, bool isNewPurchase) onPurchaseUpdated,
  }) async {
    _offline = offline;
    _onPurchaseUpdated = onPurchaseUpdated;
    _popUpWidget = popUpWidget;
    await FlutterInappPurchase.instance.initConnection;
    _products = await FlutterInappPurchase.instance.getProducts(products);
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
      _onPurchaseUpdated(productItem, true);
      restorePurchases();
    });

    _purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen((purchaseError) {
      _closePopUp();
    });
    await restorePurchases();
  }

  static List<IAPItem> get products => _products;

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
    List<PurchasedItem> purchaseHistory =
        await FlutterInappPurchase.instance.getPurchaseHistory();
    purchasesId = (purchaseHistory).map((product) => product.productId).toSet();
    purchaseHistory
        .forEach((productItem) => _onPurchaseUpdated(productItem, false));
    if (_offline) {
      if (purchasesId?.isEmpty ?? false) {
        await _BillingSharedPrefs.updatePurchases(purchasesId);
      } else {
        purchasesId = {};
      }
      purchasesId.addAll(await _BillingSharedPrefs.getPurchases());
    }
  }

  static String getPriceById(String productId) {
    IAPItem item =
        _products.firstWhere((product) => product.productId == productId);
    return item?.price;
  }

  static bool checkPurchase(String productId) {
    return purchasesId.contains(productId);
  }

  static Set<String> checkPurchases(List<String> productId) {
    Set<String> purchases = {};
    for (var purchaseId in purchasesId ?? {}) {
      if (productId.contains(purchaseId)) {
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

  static Future<void> dispose() async {
    await FlutterInappPurchase.instance.endConnection;
    if (_conectionSubscription != null) {
      unawaited(_conectionSubscription.cancel());
      _conectionSubscription = null;
    }
    if (_purchaseUpdatedSubscription != null) {
      unawaited(_purchaseUpdatedSubscription.cancel());
      _purchaseUpdatedSubscription = null;
    }
    if (_purchaseErrorSubscription != null) {
      unawaited(_purchaseErrorSubscription.cancel());
      _purchaseErrorSubscription = null;
    }
  }
}
