# Simple Code

Make Responsive and Development Faster and Easier

# Functions
Responsive and izi :)

```dart
new Container(
	height: hsz(250),
	width: wsz(250),
)
new Text("My Text",style:new TextStyle(fontSize: sz(15))); 
```

Expanded Icon and Text
```dart
expandedText(new Text("My Text")); 
expandedIcon(new Icon(Icons.wifi));
```

Animated navigator with very simples
```dart
navigator(context, duration: Duration(milliseconds: 800),page: new Page(),navFrom: NavFrom.rigth,curves: Curves.elasticOut); 
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

Just set SimpleCode context inside Widget build() on every screen

```dart
setSc(context);
``` 

You can change the standard screen size: 
```dart
setSc(context,heigthEmulator: 640,widthEmulator: 360);
``` 

heigthEmulator is a size of prototipe heigth and
widthEmulator is a size of prototipe width
```dart
640 (height) and 360 (width) are the default Android screen size in Adobe XD.
Change this to the screen size used in the prototype.
``` 


## Text
```dart
expandedText(new Text("My Text")); 

``` 
```dart
new Text("My Text",style:new TextStyle(fontSize: sz(15))); 
``` 

You can change max and min font Size

## Navigator
```dart
navigator(context, duration: Duration(milliseconds: 800),page: new Page(),navFrom: NavFrom.rigth,curves: Curves.elasticOut);
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
new Expanded(child: expandedIcon(new Icon(Icons.wifi))); 
``` 
or
```dart
expandedIcon(new Icon(Icons.wifi));
``` 
or
```dart
new Icon(Icons.youtube_searched_for, size: sz(50));
``` 
to responsive icon without expanded

### Yes, it's that easy.