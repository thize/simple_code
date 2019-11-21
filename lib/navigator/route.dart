part of simple_code;

enum Transition {
  fade_in,
  slide_from_bottom,
  slide_from_rigth,
  slide_from_left,
  slide_from_top,
  zoom_in,
}

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

  static PageRoute customPageRoute(Widget page, List<Transition> transitions,
      Curve curve, Duration duration) {
    return _RoutedPage(page, duration, curve, transitions);
  }
}

class _RoutedPage extends PageRouteBuilder {
  final Widget page;
  static Widget _page;
  final Duration duration;
  final Curve curve;
  static List<Transition> _transitions = [];
  static Animation<double> _animation;
  static Curve _curve;
  final List<Transition> transitions;
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
              _page = page;
              return _transition(0);
            });

  static _transition(int pos) {
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
        throw ("Invalid navFrom");
    }
  }

  static Widget _slideFromSide(int pos, double dx, double dy) {
    return new SlideTransition(
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
    return new ScaleTransition(
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
