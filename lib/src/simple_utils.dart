part of simple_code;

class Su {
  static set forceDev(bool newValue) => SimpleUtils.forceDev = newValue;

  static bool get isDev => SimpleUtils.isDev;

  static bool get isMobile => SimpleUtils.isMobile;

  static bool get isDesktop => SimpleUtils.isDesktop;

  static Color get randomPrimaryColor => SimpleUtils.randomPrimaryColor;

  static String enumValueString(enumValue) =>
      SimpleUtils.enumValueString(enumValue);

  static Future<bool> get hasInternetConnection =>
      SimpleUtils.hasInternetConnection;

  static void selectionClick() => SimpleUtils.selectionClick;

  static Future<String> svgToString({required String svgPath}) =>
      SimpleUtils.svgToString(svgPath: svgPath);
}

class SimpleUtils {
  static bool forceDev = false;

  static bool get isDev => forceDev || foundation.kDebugMode;

  static String enumValueString(enumValue) =>
      enumValue.toString().split('.').last;

  static bool get isDesktop =>
      Platform.isMacOS || Platform.isWindows || Platform.isLinux;

  static bool get isMobile => Platform.isAndroid || Platform.isIOS;

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

  static void selectionClick() {
    HapticFeedback.selectionClick();
  }

  static String enumToString(enumValue) => enumValue.toString().split('.').last;

  static Future<String> svgToString({required String svgPath}) async {
    return rootBundle.loadString(svgPath);
  }

  static Color get randomPrimaryColor =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];
}
