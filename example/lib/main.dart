import 'package:flutter/material.dart';
import 'package:simple_code/simple_code.dart';

void main() => runApp(new Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Page1(),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
	setSc(context);
    return new Scaffold(
        body: Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          mynavigator(),
          responsiveContainerWithExpandedIcon(),
          responsiveIcon(),
          myexpandedIcon(),
          responsiveContainerWithExpandedText(),
          myexpandedText(),
        ],
      ),
    ));
  }

  InkWell mynavigator() {
    return InkWell(
      child: Container(
        height: hsz(50.0),
        width: wsz(50.0),
        alignment: Alignment.center,
        color: Colors.red,
        child: expandedText(new Text(
            "Util Navigator\nNavType.push\nNavFrom.rigth\nSecondNavFrom.fade")),
      ),
      onTap: () {
        navigator(
          duration: Duration(milliseconds: 800),
          page: new Page2(),
          navFrom: NavFrom.rigth,
          secondNavFrom: NavFrom.fade,
          navType: NavType.push,
          curves: Curves.elasticOut,
        );
      },
    );
  }

  Expanded myexpandedText() =>
      Expanded(child: expandedText(new Text("Expanded Text")));

  Container responsiveContainerWithExpandedText() {
    return Container(
      height: hsz(50.0),
      width: wsz(50.0),
      color: Colors.red,
      alignment: Alignment.center,
      child: expandedText(new Text(
        "Text Container",
        maxLines: 2,
        textAlign: TextAlign.center,
      )),
    );
  }

  myexpandedIcon() =>
      new Expanded(child: expandedIcon(new Icon(Icons.wifi)));

  Icon responsiveIcon() =>
      new Icon(Icons.youtube_searched_for, size: sz(50.0));

  Container responsiveContainerWithExpandedIcon() {
    return new Container(
      color: Colors.yellow,
      height: hsz(50.0),
      width: wsz(50.0),
      child: expandedIcon(new Icon(Icons.hd, color: Colors.red)),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setSc(context);
    return Scaffold(
      backgroundColor: Colors.red,
      body: new Center(
        child: new FlatButton(
          child: new Text("pop"),
          onPressed: () {
            navigator(navType: NavType.pop);
          },
        ),
      ),
    );
  }
}