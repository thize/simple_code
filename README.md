# SimpleCode

## Utils Widgets
ExpandedText
```dart
ExpandedText(
  'data',
  minFontSize: 2,
),
```
TapAnimation  
<img src="https://github.com/thize/simple_code/blob/master/demo/animated_button.gif" width="360" height="640">

```dart
TapAnimation(
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

AnimationWidget  
<img src="https://github.com/thize/simple_code/blob/master/demo/animated_tween.gif" width="360" height="640">

```dart
AnimationWidget(
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

## Simple Responsivity
Responsivity izier  
wsz = size in relation to prototype Width
hsz = size in relation to prototype Height
sz = min between wsz and hsz

you can set the default type with Sc.useHsz() ||  Sc.useWsz() ||  Sc.useSz(), and to use is just:

```dart
150.a or apply(150)
```

```dart
Container(
    width: wsz(150),
    height: hsz(150),
    color: Colors.red,
),

Container(
    width: 150.wsz,
    height: 150.hsz,
    color: Colors.red,
),

Container(
    width: apply(150),
    height: apply(150),
    color: Colors.red,
),

Container(
    width: 150.a,
    height: 150.a,
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
SimpleCode.navigator.push(SimpleRoute.cupertino(Page()));
SimpleCode.navigator.pushNamed('/nextPage');
SimpleCode.navigator.showDialog(
  widget: Dialog(),
  withBlackBackground: false,
  barrierDismissible: false,
);
```

Navigator withCustomTransitions  
<img src="https://github.com/thize/simple_code/blob/master/demo/custom_page_route.gif" width="360" height="640">

```dart
SimpleCode.navigator.push(SimpleRoute.custom(
  NewPage(),
  curve: Curves.easeOutBack,
  duration: Duration(milliseconds: 600),
  transitions: [
    Transition.slideFromTop,
    Transition.slideFromRigth,
  ],
));
enum Transition {
  fadeIn,
  slideFromBottom,
  slideFromRigth,
  slideFromLeft,
  slideFromTop,
  zoomIn,
}
```

## Simple Utils
```dart
SimpleUtils.isDev
SimpleUtils.isMobile
SimpleUtils.isDesktop
SimpleUtils.randomPrimaryColor
SimpleUtils.hasInternetConnection
SimpleUtils.enumValueString(Transition.fadeIn)
SimpleUtils.selectionClick
SimpleUtils.svgToString('assets/example.svg')
```


# Getting Started

```dart
return MaterialApp(
    navigatorKey: SimpleCode.navigatorKey,
    home: MyApp(),
);
``` 

or 

```dart
SimpleCode.changeNavigatorKey(externalKey);
return MaterialApp(
    navigatorKey: externalKey,
    home: MyApp(),
);
``` 
