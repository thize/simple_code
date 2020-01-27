part of navigator;

class SimpleNavigator {
  static GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  static void changeNavigatorKey(GlobalKey<NavigatorState> newKey) =>
      key = newKey;

  static bool pop() {
    return key.currentState.pop();
  }

  static Future<void> popAndPushNamed(String routeName) async {
    await key.currentState.popAndPushNamed(routeName);
  }

  static bool canPop() {
    return key.currentState.canPop();
  }

  static Future<bool> maybePop() async {
    return await key.currentState.maybePop();
  }

  static Future<void> push(PageRoute route) async {
    await key.currentState.push(route);
  }

  static Future<void> pushNamed(String routeName) async {
    await key.currentState.pushNamed(routeName);
  }

  static Future<void> pushReplacement(PageRoute route) async {
    await key.currentState.pushReplacement(route);
  }

  static Future<void> pushReplacementNamed(String routeName) async {
    await key.currentState.pushReplacementNamed(routeName);
  }

  static Future<void> pushAndRemoveUntil(
      PageRoute route, bool Function(Route<dynamic>) predicate) async {
    await key.currentState.pushAndRemoveUntil(route, predicate);
  }

  static Future<void> pushNamedAndRemoveUntil(
      String routeName, bool Function(Route<dynamic>) predicate) async {
    await key.currentState.pushNamedAndRemoveUntil(routeName, predicate);
  }
}
