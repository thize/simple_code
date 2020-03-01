part of simple_code;

enum Transition {
  fade_in,
  slide_from_bottom,
  slide_from_rigth,
  slide_from_left,
  slide_from_top,
  zoom_in,
}

PageRoute cupertinoPageRoute(Widget page) => _Route.cupertinoPageRoute(page);
PageRoute materialPageRoute(Widget page) => _Route.materialPageRoute(page);
PageRoute customPageRoute(Widget page,
        {List<Transition> transitions = const [Transition.slide_from_rigth],
        Curve curve = Curves.linear,
        Duration duration = const Duration(milliseconds: 300)}) =>
    _Route.customPageRoute(page, transitions, curve, duration);

PageRoute customPageBuilder(Widget Function(BuildContext) builder,
        {List<Transition> transitions = const [Transition.slide_from_rigth],
        Curve curve = Curves.linear,
        Duration duration = const Duration(milliseconds: 300)}) =>
    _Route.customPageRoute(builder, transitions, curve, duration);

class _Route {
  static PageRoute cupertinoPageRoute(Widget page) {
    return CupertinoPageRoute(builder: (BuildContext context) {
      return page;
    });
  }

  static PageRoute materialPageRoute(Widget page) {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return page;
      },
    );
  }

  static PageRoute customPageRoute(dynamic page, List<Transition> transitions,
      Curve curve, Duration duration) {
    return _RoutedPage(
      page,
      duration,
      curve,
      transitions,
    );
  }
}

class _RoutedPage extends PageRouteBuilder {
  _RoutedPage(this.page, this.duration, this.curve, this.transitions)
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
            ) {
              _transitions = transitions.toList();
              _transitions.add(null);
              _animation = animation;
              _curve = curve;
              _page = page is Widget ? page : page(context);
              return _transition(0);
            });
  final dynamic page;
  static Widget _page;
  final Duration duration;
  final Curve curve;
  static List<Transition> _transitions = [];
  static Animation<double> _animation;
  static Curve _curve;
  final List<Transition> transitions;

  static Widget _transition(int pos) {
    switch (_transitions[pos]) {
      case Transition.zoom_in:
        return _zoomIn(pos + 1);
        break;
      case Transition.slide_from_rigth:
        return _slideFromSide(pos + 1, 1, 0);
        break;
      case Transition.slide_from_left:
        return _slideFromSide(pos + 1, -1, 0);
        break;
      case Transition.slide_from_top:
        return _slideFromSide(pos + 1, 0, -1);
        break;
      case Transition.slide_from_bottom:
        return _slideFromSide(pos + 1, 0, 1);
        break;
      case Transition.fade_in:
        return fadeIn(
          pos + 1,
        );
        break;
      default:
        throw ('Invalid navFrom');
    }
  }

  static Widget _slideFromSide(int pos, double dx, double dy) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(dx, dy),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animation,
          curve: _curve,
        ),
      ),
      child: _transitions[pos] == null ? _page : _transition(pos),
    );
  }

  static Widget _zoomIn(int pos) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: _animation,
          curve: _curve,
        ),
      ),
      child: _transitions[pos] == null ? _page : _transition(pos),
    );
  }

  static Widget fadeIn(int pos) {
    return FadeTransition(
      opacity: _animation,
      child: _transitions[pos] == null ? _page : _transition(pos),
    );
  }
}
