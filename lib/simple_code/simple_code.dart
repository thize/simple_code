part of simple_code;

double sz(double size) {
  return SimpleCode._size(size);
}

double wsz(double size) {
  return SimpleCode._size(size, w: true);
}

double hsz(double size) {
  return SimpleCode._size(size, h: true);
}

class SimpleCode {
  static double _emulatorHeigth = 640;
  static double _emulatorWidth = 360;
  static double get _width =>
      MediaQuery.of(SimpleNavigator.key.currentContext).size.width;
  static double get _heigth =>
      MediaQuery.of(SimpleNavigator.key.currentContext).size.height;
  static void changeEmulatorSize(
      {@required double heigth, @required double width}) {
    _emulatorHeigth = heigth;
    _emulatorWidth = width;
  }

  static double _size(double size, {bool w = false, bool h = false}) {
    try {
      if (w) {
        size = (size / _emulatorWidth) * _width;
      } else if (h) {
        size = (size / _emulatorHeigth) * _heigth;
      } else {
        size = min((size / _emulatorWidth) * _width,
            (size / _emulatorHeigth) * _heigth);
      }
    } catch (error) {
      String erro = '';
      if (SimpleNavigator.key.currentContext == null) {
        erro = 'set navigatorKey: SimpleCode.navigatorKey on MaterialApp';
      }
      throw (erro);
    }
    return size;
  }
}
