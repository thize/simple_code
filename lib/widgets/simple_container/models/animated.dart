part of simple_code;

enum SAnimationEnd {
  container,
  positioned,
  rotate,
  scale,
  translate,
}

class SAnimation {
  const SAnimation({
    this.milliseconds = 300,
    this.curve = Curves.linear,
    this.onEnd,
  });

  final int milliseconds;
  final Curve curve;
  final void Function(SAnimationEnd from) onEnd;

  Widget build({@required SContainerStyle style, @required Widget child}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: milliseconds),
      curve: curve,
      onEnd: () => onEnd(SAnimationEnd.container),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: milliseconds),
        switchOutCurve: curve,
        switchInCurve: curve,
        child: child,
      ),
      width: style.width,
      alignment: style.alignment,
      height: style.height,
      margin: style?.margin?.build(),
      padding: style?.padding?.build(),
      transform: style.matrix4,
      decoration: BoxDecoration(
        gradient: style.gradient,
        color: style.color,
        border: style.border,
        image: style.decorationImage,
        shape: style.circle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: style.circle ? null : style.borderRadius,
        boxShadow: [
          if (style.elevation != null) style.elevation?._boxShadow,
          ..._buildShadow(style),
        ],
      ),
    );
  }

  List<BoxShadow> _buildShadow(SContainerStyle style) {
    List<BoxShadow> shadows = [];
    style?.shadows?.forEach((shadow) {
      shadows.add(shadow.build());
    });
    return shadows;
  }

  Widget _buildAnimatedTween(
      {@required
          Tween<dynamic> tween,
      @required
          Widget child,
      @required
          void Function() onEnd,
      @required
          Widget Function(BuildContext _, dynamic value, Widget child)
              builder}) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: milliseconds),
      curve: curve,
      onEnd: onEnd,
      tween: tween,
      child: child,
      builder: builder,
    );
  }
}
