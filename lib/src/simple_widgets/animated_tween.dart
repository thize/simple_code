part of simple_code;

@Deprecated('Change to AnimationWidget')
class AnimatedTween extends StatelessWidget {
  const AnimatedTween({
    Key key,
    this.child,
    this.builder,
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.fastOutSlowIn,
    this.delay,
    this.inEnd = false,
    this.angle,
    this.opacity,
    this.scale,
    this.offset,
  })  : assert(opacity == null || opacity >= 0 && opacity <= 1),
        assert(child != null || builder != null),
        super(key: key);
  final Widget Function(BuildContext _, double value, Widget child) builder;
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double angle;
  final double scale;
  final Duration delay;
  final double opacity;
  final Offset offset;
  final bool inEnd;

  @override
  Widget build(BuildContext context) {
    return AnimationWidget(
      child,
      angle: angle,
      curve: curve,
      duration: duration,
      scale: scale,
      delay: delay,
      opacity: opacity,
      offset: offset,
      reversed: inEnd,
      builder: builder,
    );
  }
}
