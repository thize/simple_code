part of simple_code;

class _Navigator {
  _Navigator(this._navigatorKey);

  final GlobalKey<NavigatorState> _navigatorKey;

  void pop() {
    return _navigatorKey.currentState.pop();
  }

  Future<void> popAndPushNamed(String routeName,
      {result, Object arguments}) async {
    return _navigatorKey.currentState
        .popAndPushNamed(routeName, arguments: arguments, result: result);
  }

  bool canPop() {
    return _navigatorKey.currentState.canPop();
  }

  Future<bool> maybePop() async {
    return _navigatorKey.currentState.maybePop();
  }

  Future<void> push(PageRoute route) async {
    await _navigatorKey.currentState.push(route);
  }

  Future<void> pushNamed(String routeName, {Object arguments}) async {
    await _navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<void> pushReplacement(Route<dynamic> route, {result}) async {
    await _navigatorKey.currentState.pushReplacement(route, result: result);
  }

  Future<void> pushReplacementNamed(String routeName,
      {result, Object arguments}) async {
    await _navigatorKey.currentState
        .pushReplacementNamed(routeName, result: result, arguments: arguments);
  }

  Future<void> pushAndRemoveUntil(
      PageRoute route, bool Function(Route<dynamic>) predicate) async {
    await _navigatorKey.currentState.pushAndRemoveUntil(route, predicate);
  }

  Future<void> pushNamedAndRemoveUntil(
      String routeName, bool Function(Route<dynamic>) predicate,
      {Object arguments}) async {
    await _navigatorKey.currentState
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  Future<void> showDialog(
      {@required Widget widget,
      bool withBlackBackground = true,
      bool barrierDismissible = true}) async {
    //TODO: improve
    final Widget child = Material(
      color: Colors.transparent,
      child: barrierDismissible ? _dismissibleWidget(widget) : widget,
    );
    if (!withBlackBackground) {
      return material.showGeneralDialog(
        context: _navigatorKey.currentState.overlay.context,
        pageBuilder: (context, _, c) => child,
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 200),
      );
    }
    return material.showDialog(
      context: _navigatorKey.currentState.overlay.context,
      builder: (_) => child,
      barrierDismissible: false,
    );
  }

  Stack _dismissibleWidget(Widget child) {
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
