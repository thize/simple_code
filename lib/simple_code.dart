library simple_code;

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
part 'class.dart';
part 'expanded_text.dart';
part 'expanded_icon.dart';
part 'navigator/navigator.dart';
part 'navigator/route.dart';

double sz(double size) {
  return SimpleCode._size(size);
}

double wsz(double size) {
  return SimpleCode._size(size, w: true);
}

double hsz(double size) {
  return SimpleCode._size(size, h: true);
}

cupertinoPageRoute(Widget page) => _Route.cupertinoPageRoute(page);
materialPageRoute(Widget page) => _Route.materialPageRoute(page);
customPageRoute(Widget page,
        {List<Transition> transitions = const [Transition.slide_from_rigth],
        Curve curve = Curves.linear,
        Duration duration = const Duration(milliseconds: 300)}) =>
    _Route.customPageRoute(page, transitions, curve, duration);
