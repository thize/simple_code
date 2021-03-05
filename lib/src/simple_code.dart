part of simple_code;

enum LogType { info, verbose, debug, warning, error, wtf }

class Sc {
  static BuildContext? get context => SimpleCode.navigatorKey.currentContext;

  static void changeEmulatorSize(Size size) =>
      SimpleCode.changeEmulatorSize(size);

  static void changeNavigatorKey(GlobalKey<NavigatorState> newKey) =>
      SimpleCode.changeNavigatorKey(newKey);

  static void log(String log, [LogType type = LogType.info]) =>
      SimpleCode.log(log, type);

  static void useSz() => SimpleCode.useSz();

  static void useWsz() => SimpleCode.useWsz();

  static void useHsz() => SimpleCode.useHsz();

  static _Navigator get nav => SimpleCode.navigator;

  static GlobalKey<NavigatorState> get navKey => SimpleCode.navigatorKey;

  static set setAnimationsFps(int fps) => SimpleCode._fps = fps;
}

class SimpleCode {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static _Navigator navigator = _Navigator(navigatorKey);
  static Size _emuSize = const Size(360, 640);
  static int? _fps;

  static BuildContext? get context => SimpleCode.navigatorKey.currentContext;

  static Size get _screenSize => MediaQuery.of(context!).size;

  // ignore: use_setters_to_change_properties
  static void changeEmulatorSize(Size size) => _emuSize = size;

  // ignore: use_setters_to_change_properties
  static void changeNavigatorKey(GlobalKey<NavigatorState> newKey) =>
      navigatorKey = newKey;

  static set setAnimationsFps(int fps) => _fps = fps;

  static double _wsz(double size) {
    assert(context != null,
        'set navigatorKey: SimpleCode.navigatorKey on MaterialApp');
    return (size / _emuSize.width) * _screenSize.width;
  }

  static double _hsz(double size) {
    assert(context != null,
        'set navigatorKey: SimpleCode.navigatorKey on MaterialApp');
    return (size / _emuSize.height) * _screenSize.height;
  }

  static double _sz(double size) {
    if (size < 0) {
      final double aux = size * -1;
      return -min(_wsz(aux), _hsz(aux));
    }
    return min(_wsz(size), _hsz(size));
  }

  static final Logger _logger = Logger();

  static void log(String log, [LogType type = LogType.info]) {
    switch (type) {
      case LogType.info:
        return _logger.i(log);
      case LogType.verbose:
        return _logger.v(log);
      case LogType.debug:
        return _logger.d(log);
      case LogType.warning:
        return _logger.w(log);
      case LogType.error:
        return _logger.e(log);
      case LogType.wtf:
        return _logger.wtf(log);
      default:
        return _logger.i(log);
    }
  }

  ///Checks whether debug mode or not
  @Deprecated('Change to SimpleUtils.isDev')
  static bool get isDebugMode => SimpleUtils.isDev;

  static bool _useWsz = false;
  static bool _useHsz = false;
  static bool _useSz = true;

  static void useWsz() => _clear(wsz: true);

  static void useHsz() => _clear(hsz: true);

  static void useSz() => _clear(sz: true);

  static void _clear({bool? sz, bool? hsz, bool? wsz}) {
    _useSz = sz ?? false;
    _useHsz = hsz ?? false;
    _useWsz = wsz ?? false;
  }

  static double _apply(double value) {
    if (value.isInfinite) return value;
    if (_useWsz) return wsz(value);
    if (_useHsz) return hsz(value);
    if (_useSz) return sz(value);
    return value;
  }
}

double apply(double size) {
  return SimpleCode._apply(size);
}

double sz(double size) {
  return SimpleCode._sz(size);
}

double wsz(double size) {
  return SimpleCode._wsz(size);
}

double hsz(double size) {
  return SimpleCode._hsz(size);
}
