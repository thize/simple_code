# SimpleCode

## Utils Widgets
ExpandedText
```dart
new ExpandedText(
  'data',
  minFontSize: 2,
),
```
ExpandedIcon
```dart
new ExpandedIcon(
  Icons.wifi,
),
```
AnimatedButton  
<img src="demo/animated_button.gif" width="360" height="640">
```dart
new AnimatedButton(
  onTap: () {},
  scale: 1.3,
  angle: 30,
  offset: Offset(0, -50),
  opacity: 0.5,
  child: Container(
    width: 150,
    height: 150,
    color: Colors.red,
  ),
),
```

AnimatedTween  
<img src="demo/animated_tween.gif" width="360" height="640">
```dart
new AnimatedTween(
  offset: Offset(450, 0),
  scale: 4.5,
  angle: 250,
  delay: Duration(milliseconds: 1000),
  child: Container(
    width: 150,
    height: 150,
    color: Colors.red,
  ),
),
```

## Simple Container
Simple Container to put all style in one place (like CSS)

Without SimpleContainer
```dart
AnimatedPositioned(
  top: 5,
  left: 5,
  duration: Duration(milliseconds: 250),
  curve: Curves.easeInCubic,
  child: InkWell(
    onTap: () {},
    child: Align(
      alignment: Alignment.topRight,
      child: Transform.translate(
        offset: Offset(25, 0),
        child: Transform.rotate(
          angle: 25 * pi / 180,
          child: Transform.scale(
            scale: 1.5,
            child: AnimatedContainer(
              child: Text('Example'),
              width: 150,
              height: 50,
              margin: EdgeInsets.all(25),
              padding: EdgeInsets.all(2),
              alignment: Alignment.center,
              duration: Duration(milliseconds: 250),
              curve: Curves.easeInCubic,
              onEnd: () {},
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 4),
                      blurRadius: 4)
                ],
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage('path')),
                gradient:
                    LinearGradient(colors: [Colors.red, Colors.yellow]),
              ),
            ),
          ),
        ),
      ),
    ),
  ),
)
```

With SimpleContainer
```dart
SContainer(
  child: Text('Example'),
  gestures: SGestures(onTap: () {}, animations: SGesturesAnimation()),
  style: SContainerStyle(
    positioned: SPositioned(top: 5, left: 5, animated: true),
    alignmentExternal: Alignment.topRight,
    transform: STransform(scale: 1.5, degrees: 25, dx: 25, animated: true),
    elevation: SElevation(5),
    width: 150,
    height: 50,
    alignment: Alignment.center,
    color: Colors.green,
    animated: true,
    borderRadius: BorderRadius.circular(10),
    shadows: [SShadow(color: Colors.black, dy: 4, blurRadius: 4)],
    circle: true,
    decorationImage: DecorationImage(image: AssetImage('path')),
    gradient: LinearGradient(colors: [Colors.red, Colors.yellow]),
    margin: SEdgeInsets(all: 25),
    padding: SEdgeInsets(all: 2),
    animation: SAnimation(
      curve: Curves.easeInCubic,
      milliseconds: 250,
      onEnd: (SAnimationEnd from) {},
    ),
  ),
)
```


## Simple Responsivity
Responsivity izier  
wsz = size in relation to prototype Width  
hsz = size in relation to prototype Height  
sz = min between wsz and hsz  
```dart
Container(
    width: wsz(150),
    height: hsz(150),
    color: Colors.red,
),
```

You can change the standard screen size:  
640 (height) and 360 (width) are the default Android screen size in Adobe XD.  
Change this to the screen size used in the prototype.  
```dart
SimpleCode.changeEmulatorSize(heigth: 640, width: 360);
```

## Simple Navigator
Navigator withoutContext and builder
```dart
SimpleNavigator.push(cupertinoPageRoute(Page()));
SimpleNavigator.pushNamed('/nextPage');
SimpleNavigator.showDialog(
  widget: Dialog(),
  withBlackBackground: false,
  barrierDismissible: false,
);
```

Navigator withCustomTransitions  
<img src="demo/custom_page_route.gif" width="360" height="640">
```dart
SimpleNavigator.push(customPageRoute(
  NewPage(),
  curve: Curves.easeOutBack,
  duration: Duration(milliseconds: 600),
  transitions: [
    Transition.slide_from_top,
    Transition.slide_from_rigth,
  ],
));
enum Transition {
  fade_in,
  slide_from_bottom,
  slide_from_rigth,
  slide_from_left,
  slide_from_top,
  zoom_in,
}
```

## Simple Utils
Check if are in debug mode  
Check if have internet connection
```dart
SimpleUtils.isDev
await SimpleUtils.internetConnection
```

## Simple Billing
Simple InAppPurchases with Cache
```dart
await SimpleBilling.init(
  onPurchaseUpdated: (String productId, bool isNewPurchase) {},
  productsId: allProductsIds,
);
SimpleBilling.buyProduct(productId, context: context);
SimpleBilling.checkPurchase(productId);
SimpleBilling.checkPurchases([productOneId, productTwoId]);
SimpleBilling.getPriceById(productId);
SimpleBilling.restorePurchases();
SimpleBilling.setFakePurchases({productId});
```

## Simple RateMyApp
```dart
await SimpleRateMyApp.init({
    int minDays = 7,
    int minLaunches = 10,
    int remindDays = 7,
    int remindLaunches = 10,
    void Function() onShowIOS = openIosRateDialog,
    void Function() onShowAndroid,
    bool Function() ruleToShow,
  });
SimpleRateMyApp.show();
SimpleRateMyApp.openIosRateDialog();
SimpleRateMyApp.openStore();
SimpleRateMyApp.dontShowMore();
SimpleRateMyApp.reset();
```

# Getting Started

```dart
return MaterialApp(
    navigatorKey: SimpleNavigator.key,
    home: new MyApp(),
);
``` 

or 

```dart
SimpleNavigator.changeNavigatorKey(externalKey);
return MaterialApp(
    navigatorKey: externalKey,
    home: new MyApp(),
);
``` 
