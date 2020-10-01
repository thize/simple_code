library simple_code;

import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/foundation.dart' as foundation;

part 'simple_navigator/navigator.dart';
part 'simple_navigator/route.dart';
part 'simple_utils.dart';
part 'simple_widgets/animated_button.dart';
part 'simple_widgets/animated_tween.dart';
part 'simple_widgets/expanded_icon.dart';
part 'simple_widgets/expanded_text.dart';

class SimpleCode {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static _Navigator navigator = _Navigator(navigatorKey);
  static Size _emuSize = const Size(360, 640);
  static BuildContext get _context =>
      navigatorKey?.currentState?.overlay?.context;

  static Size get _screenSize => MediaQuery.of(_context).size;

  // ignore: use_setters_to_change_properties
  static void changeEmulatorSize(Size size) => _emuSize = size;

  // ignore: use_setters_to_change_properties
  static void changeNavigatorKey(GlobalKey<NavigatorState> newKey) =>
      navigatorKey = newKey;

  static void _checkKey() {
    if (_context == null) {
      throw 'set navigatorKey: SimpleCode.navigatorKey on MaterialApp';
    }
  }

  static double _wsz(double size) {
    _checkKey();
    return (size / _emuSize.width) * _screenSize.width;
  }

  static double _hsz(double size) {
    _checkKey();
    return (size / _emuSize.height) * _screenSize.height;
  }

  static double _sz(double size) {
    return min(_wsz(size), _hsz(size));
  }

  // static bool _isVertical(Size size) => size.width <= size.height;

  // static bool _isHorizontal(Size size) => size.height < size.width;
}

double sz(double size) {
  return SimpleCode._sz(size);
}

double wsz(double size) {
  return SimpleCode._wsz(size);
}

double hsz(double size) {
  return SimpleCode._hsz(
    size,
  );
}
