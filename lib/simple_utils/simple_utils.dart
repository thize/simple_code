part of simple_code;

class SimpleUtils {
  static bool get isDev => foundation.kDebugMode;

  static Future<bool> get internetConnection async {
    try {
      final result = await InternetAddress.lookup('example.com');
      bool connected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      return connected;
    } on SocketException catch (_) {
      return false;
    }
  }
}
