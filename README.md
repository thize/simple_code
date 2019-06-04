# Simple Code

Make Responsive and Development Faster and Easier

# Functions
Responsive and izi :)
```dart
Container(
height: sC.size(250),
width: sC.size(250),
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
heigthEmulator is a size of prototipe heigth and
widthEmulator is a size of prototipe width
```dart
640 (height) and 360 (width) are the default Android screen size in Adobe XD.
Change this to the screen size used in the prototype.
``` 

You can change the standard screen size: 
```dart
SimpleCode sC = new SimpleCode(context: context,heigthEmulator: 640,widthEmulator: 360);
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
```dart
new Text("My Text",style:new TextStyle(fontSize:sC.size(15))); 
``` 

You can change max and min font Size

## Navigator
```dart
sC.navigator(duration: Duration(milliseconds: 800),page: new Page(),navFrom: NavFrom.rigth,curves: Curves.elasticOut);
``` 
You can choose one or two NavFrom, to match animations
```dart
navFrom: NavFrom.rigth, secondNavFrom: NavFrom.fade 
is other than
navFrom: NavFrom.fade, secondNavFrom: NavFrom.rigth
``` 

Animations:
```dart
fade, left, rigth, bottom, top, scale, rotation,
``` 
Curves:
```dart
 All types of Curves
 Ex: Curves.easeIn
``` 

Types:
    
```dart
 pop, push, pushReplacement
``` 
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
new Icon(Icons.youtube_searched_for, size: sC.size(50));
``` 
to responsive icon without expanded

### Yes, it's that easy.