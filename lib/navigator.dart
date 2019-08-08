part of simple_code;

enum NavType {
  pop,
  push,
  pushReplacement,
}

enum NavFrom {
  fade,
  left,
  rigth,
  bottom,
  top,
  scale,
  rotation,
}

_customNavigator(
  context, {
  Widget page,
  NavFrom navFrom = NavFrom.rigth,
  NavType navType = NavType.push,
  NavFrom secondNavFrom,
  Duration duration,
  Curve curve = Curves.linear,
}) {
  if (navType == NavType.pop) {
    Navigator.of(context).pop();
  } else if (page != null) {
    if (duration == null) {
      duration = new Duration(milliseconds: 300);
    }
    if (navType == NavType.push) {
      Navigator.of(context).push(_RoutedPage(
          page: page,
          duration: duration,
          navFrom: navFrom,
          secondNavFrom: secondNavFrom,
          curve: curve));
    } else if (navType == NavType.pushReplacement) {
      Navigator.of(context).pushReplacement(_RoutedPage(
          page: page,
          duration: duration,
          navFrom: navFrom,
          curve: curve,
          secondNavFrom: secondNavFrom));
    }
  } else {
    print("Without page");
  }
}

_RoutedPage _animatedRoute(
  context, {
  Widget page,
  NavFrom navFrom = NavFrom.rigth,
  NavFrom secondNavFrom,
  Duration duration,
  Curve curve = Curves.linear,
}) {
  if (duration == null) {
    duration = new Duration(milliseconds: 200);
  }
  return _RoutedPage(
      page: page,
      duration: duration,
      navFrom: navFrom,
      secondNavFrom: secondNavFrom,
      curve: curve);
}

class _RoutedPage extends PageRouteBuilder {
  final Widget page;
  final Duration duration;
  final NavFrom navFrom;
  final NavFrom secondNavFrom;
  final Curve curve;

  _RoutedPage(
      {this.page, this.duration, this.navFrom, this.secondNavFrom, this.curve})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionDuration: duration,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              _returnFrom(
                child,
                animation,
                navFrom,
                curve,
                secondNavFrom: secondNavFrom,
              ),
        );
}

_returnFrom(child, animation, NavFrom navFrom, curve, {secondNavFrom}) {
  switch (navFrom) {
    case NavFrom.scale:
      return _scale(animation, child, secondNavFrom, curve);
      break;
    case NavFrom.rigth:
      return _rigth(animation, child, 1, 0, secondNavFrom, curve);
      break;
    case NavFrom.left:
      return _rigth(animation, child, -1, 0, secondNavFrom, curve);
      break;
    case NavFrom.top:
      return _rigth(animation, child, 0, -1, secondNavFrom, curve);
      break;
    case NavFrom.bottom:
      return _rigth(animation, child, 0, 1, secondNavFrom, curve);
      break;
    case NavFrom.fade:
      return _fade(animation, child, secondNavFrom, curve);
      break;
    case NavFrom.rotation:
      return _rotation(animation, child, secondNavFrom, curve);
      break;
    default:
      throw ("Invalid navFrom");
  }
}

_rigth(animation, child, double dx, double dy, secondNavFrom, curve) {
  return new SlideTransition(
    position: Tween<Offset>(
      begin: Offset(dx, dy),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: curve,
      ),
    ),
    child: secondNavFrom != null
        ? _returnFrom(child, animation, secondNavFrom, curve)
        : child,
  );
}

_rotation(animation, child, secondNavFrom, curve) {
  return RotationTransition(
    turns: Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: curve,
      ),
    ),
    child: secondNavFrom != null
        ? _returnFrom(child, animation, secondNavFrom, curve)
        : child,
  );
}

_scale(animation, child, secondNavFrom, Curve curve) {
  return new ScaleTransition(
    scale: Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: curve,
      ),
    ),
    child: secondNavFrom != null
        ? _returnFrom(child, animation, secondNavFrom, curve)
        : child,
  );
}

_fade(animation, child, secondNavFrom, curve) {
  return FadeTransition(
    opacity: animation,
    child: secondNavFrom != null
        ? _returnFrom(child, animation, secondNavFrom, curve)
        : child,
  );
}
