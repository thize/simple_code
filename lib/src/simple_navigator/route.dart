part of simple_code;

enum SCTransition {
  fadeIn,
  slideFromBottom,
  slideFromRigth,
  slideFromLeft,
  slideFromTop,
  zoomIn,
}

class SimpleRoute {
  static PageRoute cupertino(Widget page) {
    return CupertinoPageRoute(builder: (BuildContext context) {
      return page;
    });
  }

  static PageRoute material(Widget page) {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return page;
      },
    );
  }

  static PageRoute custom(
    Widget page, {
    List<SCTransition> transitions = const [SCTransition.fadeIn],
    Curve curve = Curves.linear,
    Duration duration = const Duration(milliseconds: 600),
  }) {
    return _RoutedPage(page, duration, curve, transitions);
  }
}

class _RoutedPage extends PageRouteBuilder {
  _RoutedPage(this.page, this.duration, this.curve, this.transitions)
      : super(
          pageBuilder: (a, b, c) => page,
          transitionDuration: duration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _transition(animation, curve, transitions, 0, child);
          },
        );

  final Widget page;
  final Duration duration;
  final Curve curve;
  final List<SCTransition> transitions;

  static Widget _transition(Animation<double> animation, Curve curve,
      List<SCTransition> transitions, int index, Widget widget) {
    final Widget child = transitions.length - 1 == index
        ? widget
        : _transition(animation, curve, transitions, index + 1, widget);
    switch (transitions[index]) {
      case SCTransition.zoomIn:
        return _zoomIn(animation, curve, child);
      case SCTransition.slideFromRigth:
        return _slideFromSide(Alignment.centerRight, animation, curve, child);
      case SCTransition.slideFromLeft:
        return _slideFromSide(Alignment.centerLeft, animation, curve, child);
      case SCTransition.slideFromTop:
        return _slideFromSide(Alignment.topCenter, animation, curve, child);
      case SCTransition.slideFromBottom:
        return _slideFromSide(Alignment.bottomCenter, animation, curve, child);
      case SCTransition.fadeIn:
        return _fadeIn(animation, child);
      default:
        throw 'Invalid navFrom';
    }
  }

  static Widget _slideFromSide(
      Alignment side, Animation<double> parent, Curve curve, Widget child) {
    return SlideTransition(
        position: Tween<Offset>(begin: Offset(side.x, side.y), end: Offset.zero)
            .animate(CurvedAnimation(parent: parent, curve: curve)),
        child: child);
  }

  static Widget _zoomIn(Animation<double> parent, Curve curve, Widget child) {
    return ScaleTransition(
        scale: Tween<double>(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(parent: parent, curve: curve)),
        child: child);
  }

  static Widget _fadeIn(Animation<double> opacity, Widget child) {
    return FadeTransition(opacity: opacity, child: child);
  }
}
