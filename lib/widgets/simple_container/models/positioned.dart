part of simple_code;

class SPositioned {
  SPositioned({
    this.bottom,
    this.left,
    this.right,
    this.top,
    this.width,
    this.height,
    this.animated = false,
  });
  final double width;
  final double bottom;
  final double height;
  final double left;
  final double right;
  final double top;
  final bool animated;

  Widget build({@required Widget child, @required SContainerStyle style}) {
    if (animated) {
      return AnimatedPositioned(
        duration: Duration(milliseconds: style.animation.milliseconds),
        curve: style.animation.curve,
        bottom: bottom,
        onEnd: style.animation.onEnd == null
            ? null
            : () => style.animation.onEnd(SAnimationEnd.positioned),
        height: height,
        left: left,
        right: right,
        top: top,
        width: width,
        child: child,
      );
    }
    return Positioned(
      bottom: bottom,
      height: height,
      left: left,
      right: right,
      top: top,
      width: width,
      child: child,
    );
  }
}
