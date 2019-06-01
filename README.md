# Simple Code

## Responsiveness very izi
#### widget(size: 250),

## Animated Navigator with 1 line
### navigator(duration: Duration(milliseconds: 800),page: new Page2(),navFrom: NavFrom.rigth,curves: Curves.elasticOut);

## Getting Started

### Just create a new SimpleCode inside Widget build()

### SimpleCode simpleCode = new SimpleCode(context: context);
You can change the standard screen size: SimpleCode simpleCode = new SimpleCode(context: context,heigthEmulator: 640,widthEmulator: 360);
heigthEmulator is a size of prototipe heigth
widthEmulator is a size of prototipe width

# To use:

## Color
simpleCode.color(0xffffffff); 
Types Accepted: 0xffffffff, "ffffff", "#ffffff", "rgb(255, 255, 255)", "rgb(255, 255, 255,1.0)"

## Text
simpleCode.expandedText(new Text("My Text")); 
You can change max and min font Size

## Navigator
simpleCode.navigator(duration: Duration(milliseconds: 800),page: new Page(),navFrom: NavFrom.rigth,curves: Curves.elasticOut);
You can choose one or two NavFrom, to match animations
navFrom: NavFrom.rigth, secondNavFrom: NavFrom.fade is other than navFrom: NavFrom.fade, secondNavFrom: NavFrom.rigth

Animations:
    fade, left, rigth, bottom, top, scale, rotation,
Curves:
    Curves.(all)
Types:
    pop, push, pushReplacement

## Icons
new Expanded(child: simpleCode.expandedIcon(new Icon(Icons.wifi))); 
or
simpleCode.expandedIcon(new Icon(Icons.wifi));
or
new Icon(Icons.youtube_searched_for, size: simpleCode.widget(size: 50));
to responsive icon without expanded

Yes, it's that easy.