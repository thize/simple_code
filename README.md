# Simple Code

Make Development Faster, Easier and Responsive

# Functions
## Navigator without context
## ExpandedText
## ExpandedIcon
## Responsive size: hsz(), wsz(), sz()


```dart
new Container(
	height: hsz(250),
	width: wsz(250),
)
new Text("My Text",style:new TextStyle(fontSize: sz(15))); 
```

Expanded Icon and Text
```dart
ExpandedText("My Text"); 
ExpandedIcon(Icons.wifi);
```

Animated navigator with very simples
```dart
SimpleNavigator.push(customPageRoute(
    Page(),
    curve: Curves.easeOutBack,
    duration: Duration(milliseconds: 600),
    transitions: [
        Transition.slide_from_top,
        Transition.slide_from_rigth,
        Transition.fade_in,
    ],
));
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

```dart
return MaterialApp(
    navigatorKey: SimpleCode.navigatorKey,
    home: new MyApp(),
);
``` 

You can change the standard screen size: 
```dart
SimpleCode.changeEmulatorSize(heigth: 640, width: 360);
``` 

heigth is a size of prototipe heigth and
width is a size of prototipe width
```dart
640 (height) and 360 (width) are the default Android screen size in Adobe XD.
Change this to the screen size used in the prototype.
``` 


## Text
```dart
ExpandedText("My Text"); 

``` 
```dart
new Text("My Text",style: new TextStyle(fontSize: sz(15))); 
``` 

You can change max and min font Size

## Navigator without context
```dart
SimpleNavigator.push(cupertinoPageRoute(Page()));
```

You can choose a list of Transitions, to match animations

``` dart
SimpleNavigator.push(customPageRoute(
    Page(),
    curve: Curves.easeOutBack,
    duration: Duration(milliseconds: 600),
    transitions: [
        Transition.slide_from_top,
        Transition.slide_from_rigth,
        Transition.fade_in,
    ],
));
``` 

Transitions:
```dart
fade_in, slide_from_bottom, slide_from_rigth, slide_from_left, slide_from_top, zoom_in,
``` 
Curves:
```dart
 All types of Curves
 Ex: Curves.easeIn
``` 

Types:
    
```dart
 pop, push, pushReplacement, etc... 
``` 
## Icons
```dart
new Expanded(child: ExpandedIcon(Icons.wifi)); 
``` 
or
```dart
ExpandedIcon(Icons.wifi);
``` 
or
```dart
new Icon(Icons.youtube_searched_for, size: sz(50));
``` 
to responsive icon without expanded

### Yes, it's that easy.