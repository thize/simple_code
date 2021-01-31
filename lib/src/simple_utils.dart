part of simple_code;

class Su {
  static bool get isDev => SimpleUtils.isDev;

  static bool get isMobile => SimpleUtils.isMobile;

  static bool get isDesktop => SimpleUtils.isDesktop;

  static Color get randomPrimaryColor => SimpleUtils.randomPrimaryColor;

  static String enumValueString(enumValue) =>
      SimpleUtils.enumValueString(enumValue);

  static Future<bool> get hasInternetConnection =>
      SimpleUtils.hasInternetConnection;

  static void vibrate() => SimpleUtils.vibrate;

  static Future<String> svgToString({@required String svgPath}) =>
      SimpleUtils.svgToString(svgPath: svgPath);

  static Future<void> openInternetPage(String url) =>
      SimpleUtils.openInternetPage(url);
}

class SimpleUtils {
  static bool get isDev => foundation.kDebugMode;

  static String enumValueString(enumValue) =>
      enumValue.toString().split('.').last;

  static bool get isDesktop =>
      Platform.isMacOS || Platform.isWindows || Platform.isLinux;

  static bool get isMobile => Platform.isAndroid || Platform.isIOS;

  @Deprecated('Change to hasInternetConnection')
  static Future<bool> get internetConnection async => hasInternetConnection;

  static Future<bool> get hasInternetConnection async {
    try {
      final result = await InternetAddress.lookup('example.com');
      final bool connected =
          result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      return connected;
    } catch (e) {
      return false;
    }
  }

  static Future<void> openInternetPage(String url) async {
    try {
      await launch(url);
    } catch (e) {
      SimpleCode.log('openInternetPage', LogType.error);
    }
  }

  static void vibrate() {
    HapticFeedback.selectionClick();
  }

  static String enumToString(enumValue) => enumValue.toString().split('.').last;

  static Future<String> svgToString({@required String svgPath}) async {
    return rootBundle.loadString(svgPath);
  }

  /// Get Random Primary Color
  static Color get randomPrimaryColor =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];
}
