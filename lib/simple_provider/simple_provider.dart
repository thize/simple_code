import 'dart:math';

import 'package:flutter/material.dart';

Map<String, List<void Function()>> _moKeys = {};
int _autoIncrement = 0;

class SPVar<T> {
  SPVar({value}) {
    marValue = value;
    key = _generateNewKey();
  }
  T marValue;
  String key;

  void setValue(T newValue) {
    marValue = newValue;
    _moKeys[key]?.forEach((element) {
      element();
    });
  }

  T get value => marValue;

  bool get hasValue => value != null;

  String _generateNewKey() {
    return Random().nextDouble().toString() + '${_autoIncrement++}';
  }
}

class SPBuilder extends StatefulWidget {
  const SPBuilder({@required this.mars, @required this.builder});
  final List<SPVar> mars;
  final WidgetBuilder builder;

  @override
  _MuilderState createState() => _MuilderState();
}

class _MuilderState extends State<SPBuilder> {
  void Function() update;
  List<String> keys = [];
  @override
  void initState() {
    update = () => setState(() {});
    widget.mars.forEach((mar) {
      keys.add(mar.key);
    });
    keys?.forEach((element) {
      try {
        _moKeys[element].add(update);
      } catch (e) {
        _moKeys[element] = [];
        _moKeys[element].add(update);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }

  @override
  void dispose() {
    keys?.forEach((element) {
      _moKeys[element].remove(update);
    });
    super.dispose();
  }
}
