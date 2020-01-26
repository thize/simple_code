part of navigator;

class SimpleNavigator {
  static bool pop() {
    return SimpleCode.navigatorKey.currentState.pop();
  }

  static Future<void> popAndPushNamed(String routeName) async {
    await SimpleCode.navigatorKey.currentState.popAndPushNamed(routeName);
  }

  static bool canPop() {
    return SimpleCode.navigatorKey.currentState.canPop();
  }

  static Future<bool> maybePop() async {
    return await SimpleCode.navigatorKey.currentState.maybePop();
  }

  static Future<void> push(PageRoute route) async {
    await SimpleCode.navigatorKey.currentState.push(route);
  }

  static Future<void> pushNamed(String routeName) async {
    await SimpleCode.navigatorKey.currentState.pushNamed(routeName);
  }

  static Future<void> pushReplacement(PageRoute route) async {
    await SimpleCode.navigatorKey.currentState.pushReplacement(route);
  }

  static Future<void> pushReplacementNamed(String routeName) async {
    await SimpleCode.navigatorKey.currentState.pushReplacementNamed(routeName);
  }

  static Future<void> pushAndRemoveUntil(
      PageRoute route, bool Function(Route<dynamic>) predicate) async {
    await SimpleCode.navigatorKey.currentState
        .pushAndRemoveUntil(route, predicate);
  }

  static Future<void> pushNamedAndRemoveUntil(
      String routeName, bool Function(Route<dynamic>) predicate) async {
    await SimpleCode.navigatorKey.currentState
        .pushNamedAndRemoveUntil(routeName, predicate);
  }
}
