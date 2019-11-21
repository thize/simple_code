```dart
import 'package:flutter/material.dart';
import 'package:simple_code/simple_code.dart';

void main() => runApp(new Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: SimpleCode.navigatorKey,
      home: new Page1(),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          mynavigator(context),
          responsiveContainerWithExpandedIcon(),
          responsiveIcon(),
          myexpandedIcon(),
          responsiveContainerWithExpandedText(),
          myexpandedText(),
        ],
      ),
    ));
  }

  InkWell mynavigator(context) {
    return InkWell(
      child: Container(
        height: hsz(50.0),
        width: wsz(50.0),
        alignment: Alignment.center,
        color: Colors.red,
        child: ExpandedText(
            "Util Navigator\nNavType.push\nNavFrom.rigth\nSecondNavFrom.fade"),
      ),
      onTap: () {
        pushWithoutContext();
      },
    );
  }

  pushWithoutContext() {
    SimpleNavigator.push(customPageRoute(
      Page2(),
      curve: Curves.easeOutBack,
      duration: Duration(milliseconds: 600),
      transitions: [
        Transition.slide_from_top,
        Transition.slide_from_rigth,
        Transition.fade_in,
      ],
    ));
    //SimpleNavigator.push(cupertinoPageRoute(Page2()));
    //SimpleNavigator.push(materialPageRoute(Page2()));
  }

  Expanded myexpandedText() => Expanded(child: ExpandedText("Expanded Text"));

  Container responsiveContainerWithExpandedText() {
    return Container(
      height: hsz(50.0),
      width: wsz(50.0),
      color: Colors.red,
      alignment: Alignment.center,
      child: ExpandedText(
        "Text Container",
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
    );
  }

  myexpandedIcon() => new Expanded(child: ExpandedIcon(Icons.wifi));

  Icon responsiveIcon() => new Icon(Icons.youtube_searched_for, size: sz(50.0));

  Container responsiveContainerWithExpandedIcon() {
    return new Container(
      color: Colors.yellow,
      height: hsz(50.0),
      width: wsz(50.0),
      child: ExpandedIcon(Icons.hd, color: Colors.red),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: new Center(
        child: new FlatButton(
          child: new Text("pop"),
          onPressed: () {
            popWithOutContext();
          },
        ),
      ),
    );
  }

  popWithOutContext() {
    SimpleNavigator.pop();
  }
}

``` 