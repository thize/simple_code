part of simple_code;

class SimpleNavigator {
  static GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  static void changeNavigatorKey(GlobalKey<NavigatorState> newKey) =>
      key = newKey;

  static bool pop() {
    return key.currentState.pop();
  }

  static Future<void> popAndPushNamed(String routeName,
      {dynamic result, Object arguments}) async {
    await key.currentState
        .popAndPushNamed(routeName, arguments: arguments, result: result);
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

  static Future<void> pushNamed(String routeName, {Object arguments}) async {
    await key.currentState.pushNamed(routeName, arguments: arguments);
  }

  static Future<void> pushReplacement(Route<dynamic> route,
      {dynamic result}) async {
    await key.currentState.pushReplacement(route, result: result);
  }

  static Future<void> pushReplacementNamed(String routeName,
      {dynamic result, Object arguments}) async {
    await key.currentState
        .pushReplacementNamed(routeName, result: result, arguments: arguments);
  }

  static Future<void> pushAndRemoveUntil(
      PageRoute route, bool Function(Route<dynamic>) predicate) async {
    await key.currentState.pushAndRemoveUntil(route, predicate);
  }

  static Future<void> pushNamedAndRemoveUntil(
      String routeName, bool Function(Route<dynamic>) predicate,
      {Object arguments}) async {
    await key.currentState
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  static Future<void> showDialog(
      {@required Widget widget,
      bool withBlackBackground = true,
      bool barrierDismissible = true}) async {
    Widget child = Material(
      color: Colors.transparent,
      child: barrierDismissible ? _dismissibleWidget(widget) : widget,
    );
    if (!withBlackBackground) {
      return await material.showGeneralDialog(
        context: key.currentState.overlay.context,
        pageBuilder: (context, _, c) => child,
        barrierDismissible: false,
        transitionDuration: Duration(milliseconds: 200),
      );
    }
    return await material.showDialog(
      context: key.currentState.overlay.context,
      builder: (_) => child,
      barrierDismissible: false,
    );
  }

  static Stack _dismissibleWidget(Widget child) {
    return Stack(
      children: <Widget>[
        InkWell(
            onTap: () => pop(),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent),
        child,
      ],
    );
  }
}
