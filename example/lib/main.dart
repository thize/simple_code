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
    SimpleCode util = new SimpleCode(
        context: context, heigthEmulator: 640, widthEmulator: 360);
    return new Scaffold(
        body: Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          navigator(util),
          responsiveContainerWithExpandedIcon(util),
          responsiveIcon(util),
          expandedIcon(util),
          responsiveContainerWithExpandedText(util),
          expandedText(util),
        ],
      ),
    ));
  }

  InkWell navigator(SimpleCode util) {
    return InkWell(
      child: Container(
        height: util.size(50.0),
        width: util.size(50.0),
        alignment: Alignment.center,
        color: util.color("#aafaff"),
        child: util.expandedText(new Text(
            "Util Navigator\nNavType.push\nNavFrom.rigth\nSecondNavFrom.fade")),
      ),
      onTap: () {
        util.navigator(
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

  Expanded expandedText(SimpleCode responsive) =>
      Expanded(child: responsive.expandedText(new Text("Expanded Text")));

  Container responsiveContainerWithExpandedText(SimpleCode responsive) {
    return Container(
      height: responsive.size(50.0),
      width: responsive.size(50.0),
      color: Colors.red,
      alignment: Alignment.center,
      child: responsive.expandedText(new Text(
        "Text Container",
        maxLines: 2,
        textAlign: TextAlign.center,
      )),
    );
  }

  expandedIcon(SimpleCode responsive) =>
      new Expanded(child: responsive.expandedIcon(new Icon(Icons.wifi)));

  Icon responsiveIcon(SimpleCode responsive) =>
      new Icon(Icons.youtube_searched_for, size: responsive.size(50.0));

  Container responsiveContainerWithExpandedIcon(SimpleCode responsive) {
    return new Container(
      color: Colors.yellow,
      height: responsive.size(50.0),
      width: responsive.size(50.0),
      child: responsive.expandedIcon(new Icon(Icons.hd, color: Colors.red)),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SimpleCode util = new SimpleCode(context: context);
    return Scaffold(
      backgroundColor: Colors.red,
      body: new Center(
        child: new FlatButton(
          child: new Text("pop"),
          onPressed: () {
            util.navigator(navType: NavType.pop);
          },
        ),
      ),
    );
  }
}
