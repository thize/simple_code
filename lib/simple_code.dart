library simple_code;

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
part 'autoSizeText/auto_size_text.dart';
part 'autoSizeText/auto_size_group.dart';
part 'class.dart';
part 'navigator.dart';

_SimpleCode _sc;

void navigator(context,
    {Duration duration,
    NavFrom navFrom = NavFrom.rigth,
    NavFrom secondNavFrom,
    NavType navType = NavType.push,
    Widget page,
    Curve curves = Curves.linear}) {
  _sc.navigator(
      context: context,
      duration: duration,
      navFrom: navFrom,
      secondNavFrom: secondNavFrom,
      navType: navType,
      page: page,
      curves: curves);
}

double sz(double size) {
  return _sc._size(size);
}

double wsz(double size) {
  return _sc._size(size, w: true);
}

double hsz(double size) {
  return _sc._size(size, h: true);
}

Widget expandedText(
  Text textWidget, {
  AutoSizeGroup group,
  double maxFontSize = double.infinity,
  double minFontSize = 6.0,
  Widget overflowReplacement,
  List<double> presetFontSizes,
  double stepGranularity = 1,
  bool wrapWords = true,
}) {
  return _sc._expandedText(
    textWidget,
    group: group,
    maxFontSize: maxFontSize,
    minFontSize: minFontSize,
    overflowReplacement: overflowReplacement,
    presetFontSizes: presetFontSizes,
    stepGranularity: stepGranularity,
    wrapWords: wrapWords,
  );
}

Widget expandedIcon(Icon icon,
    {double maxSize = double.maxFinite, double minSize = 2.0}) {
  return _sc._expandedIcon(icon, maxSize: maxSize, minSize: minSize);
}

void setSc(BuildContext context,
    {double heigthEmulator = 640.0, double widthEmulator = 360.0}) {
  _sc = new _SimpleCode(
    heigthEmulator: heigthEmulator,
    widthEmulator: widthEmulator,
    heigth: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
  );
}
