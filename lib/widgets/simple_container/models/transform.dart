part of simple_code;

class STransform {
  STransform(
      {this.scale, this.degrees, this.dx, this.dy, this.animated = false});
  final double scale;
  final double degrees;
  final double dx;
  final double dy;
  final bool animated;

  SContainerStyle _style;

  Widget build({@required SContainerStyle style, @required Widget child}) {
    _style = style;
    return _translate(_scale(_rotate(child)));
  }

  Widget _rotate(Widget child) {
    if (degrees != null) {
      if (animated) {
        return _style.animation._buildAnimatedTween(
          tween:
              Tween<double>(begin: degrees * pi / 180, end: degrees * pi / 180),
          child: child,
          onEnd: () => _style.animation.onEnd(SAnimationEnd.rotate),
          builder: (_, value, Widget child) {
            return Transform.rotate(angle: value, child: child);
          },
        );
      }
      return Transform.rotate(angle: degrees * pi / 180, child: child);
    }
    return child;
  }

  Widget _scale(Widget child) {
    if (scale != null) {
      if (animated) {
        return _style.animation._buildAnimatedTween(
          tween: Tween<double>(begin: scale, end: scale),
          child: child,
          onEnd: () => _style.animation.onEnd(SAnimationEnd.scale),
          builder: (_, value, Widget child) {
            return Transform.scale(scale: value, child: child);
          },
        );
      }
      return Transform.scale(scale: scale, child: child);
    }
    return child;
  }

  Widget _translate(Widget child) {
    if (dx != null || dy != null) {
      if (animated) {
        return _style.animation._buildAnimatedTween(
          tween: Tween<double>(begin: dx ?? 0, end: dx ?? 0),
          child: child,
          onEnd: () => _style.animation.onEnd(SAnimationEnd.translate),
          builder: (_, dxValue, Widget child) {
            return _style.animation._buildAnimatedTween(
              tween: Tween<double>(begin: dy ?? 0, end: dy ?? 0),
              child: child,
              onEnd: () => _style.animation.onEnd(SAnimationEnd.translate),
              builder: (_, dyValue, Widget child) {
                return Transform.translate(
                  offset: Offset(dxValue, dyValue),
                  child: child,
                );
              },
            );
          },
        );
      }
      return Transform.translate(offset: Offset(dx, dy), child: child);
    }
    return child;
  }
}
