part of simple_code;

class SimpleUtils {
  static bool get isDev => foundation.kDebugMode;

  static String enumValueString(enumValue) =>
      enumValue.toString().split('.').last;

  static Future<bool> get internetConnection async {
    try {
      final result = await InternetAddress.lookup('example.com');
      final bool connected =
          result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      return connected;
    } catch (e) {
      return false;
    }
  }
}
