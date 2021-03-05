part of simple_code;

class _Navigator {
  _Navigator(this._navigatorKey);

  final GlobalKey<NavigatorState> _navigatorKey;

  void pop() {
    return _navigatorKey.currentState?.pop();
  }

  Future? popAndPushNamed(String routeName, {result, Object? arguments}) async {
    return _navigatorKey.currentState
        ?.popAndPushNamed(routeName, arguments: arguments, result: result);
  }

  bool? canPop() {
    return _navigatorKey.currentState?.canPop();
  }

  Future? maybePop() async {
    return _navigatorKey.currentState?.maybePop();
  }

  Future push(PageRoute route) async {
    await _navigatorKey.currentState?.push(route);
  }

  Future pushNamed(String routeName, {Object? arguments}) async {
    await _navigatorKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  Future pushReplacement(Route<dynamic> route, {result}) async {
    await _navigatorKey.currentState?.pushReplacement(route, result: result);
  }

  Future pushReplacementNamed(String routeName,
      {result, Object? arguments}) async {
    await _navigatorKey.currentState
        ?.pushReplacementNamed(routeName, result: result, arguments: arguments);
  }

  Future pushAndRemoveUntil(
      PageRoute route, bool Function(Route<dynamic>) predicate) async {
    await _navigatorKey.currentState?.pushAndRemoveUntil(route, predicate);
  }

  Future pushNamedAndRemoveUntil(
      String routeName, bool Function(Route<dynamic>) predicate,
      {Object? arguments}) async {
    await _navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  Future showDialog({
    required Widget widget,
    bool withBlackBackground = true,
    bool barrierDismissible = true,
    bool useSafeArea = false,
  }) async {
    return material.showDialog(
      context: _navigatorKey.currentContext!,
      builder: (_) => widget,
      barrierDismissible: barrierDismissible,
      barrierColor: withBlackBackground ? Colors.black45 : Colors.transparent,
      useSafeArea: useSafeArea,
    );
  }
}
