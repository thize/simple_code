# Simple Code

Plugin made to make development faster and easier

# Functions
Responsiveness izi
```dart
Container(
height: sC.widget(size: 250),
width: sC.widget(size: 250),
)
```

Expanded Icon and Text
```dart
sC.expandedText(new Text("My Text")); 
sC.expandedIcon(new Icon(Icons.wifi));
```

All Color types
```dart
sC.color(0xffffffff); 
sC.color("ffffff"); 
sC.color("#ffffff"); 
sC.color("rgb(255, 255, 255)"); 
sC.color("rgb(255, 255, 255,1.0)"); 
``` 

Animated navigator with very simples
```dart
navigator(duration: Duration(milliseconds: 800),page: new Page(),navFrom: NavFrom.rigth,curves: Curves.elasticOut); 
``` 

# To use:

## Import the package
To use this plugin, follow the [plugin installation instructions](https://pub.dev/packages/simple_code#-installing-tab-).

## Use the plugin
Add the following import to your Dart code:
```dart
import 'package:simple_code/simple_code.dart';
```
# Getting Started

Just create a new SimpleCode inside Widget build()

```dart
SimpleCode sC = new SimpleCode(context: context);
``` 
You can change the standard screen size: 
```dart
SimpleCode sC = new SimpleCode(context: context,heigthEmulator: 640,widthEmulator: 360);
``` 
heigthEmulator is a size of prototipe heigth\n
widthEmulator is a size of prototipe width
```dart
640(heigth) and 360(width) is\nthe standard screen size of Android on Adobe XD,
``` 

## Color
```dart
sC.color(0xffffffff); 
``` 
Types Accepted: 0xffffffff, "ffffff", "#ffffff", "rgb(255, 255, 255)", "rgb(255, 255, 255,1.0)"

## Text
```dart
sC.expandedText(new Text("My Text")); 
``` 
You can change max and min font Size

## Navigator
```dart
sC.navigator(duration: Duration(milliseconds: 800),page: new Page(),navFrom: NavFrom.rigth,curves: Curves.elasticOut);
``` 
You can choose one or two NavFrom, to match animations
navFrom: NavFrom.rigth, secondNavFrom: NavFrom.fade is other than navFrom: NavFrom.fade, secondNavFrom: NavFrom.rigth

Animations:
    fade, left, rigth, bottom, top, scale, rotation,
Curves:
    Curves.(all)
Types:
    pop, push, pushReplacement

## Icons
```dart
new Expanded(child: sC.expandedIcon(new Icon(Icons.wifi))); 
``` 
or
```dart
sC.expandedIcon(new Icon(Icons.wifi));
``` 
or
```dart
new Icon(Icons.youtube_searched_for, size: sC.widget(size: 50));
``` 
to responsive icon without expanded

### Yes, it's that easy.