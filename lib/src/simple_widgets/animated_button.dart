part of simple_code;

@Deprecated('Change to TapAnimation')
class AnimatedButton extends StatelessWidget {
  const AnimatedButton({
    @required this.onTap,
    Key key,
    this.child,
    this.builder,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeOutCirc,
    this.onTapDelay = 100,
    this.angle,
    this.opacity,
    this.scale,
    this.offset,
    this.highlightColor,
    this.splashColor,
  })  : assert(opacity == null || opacity >= 0 && opacity <= 1),
        assert(builder != null || child != null),
        assert(builder == null || child == null),
        super(key: key);
  final Widget Function(bool tapped, double animationValue) builder;
  final Widget child;
  final Duration duration;
  final Curve curve;
  final void Function() onTap;

  /// On Tap Delay in milliseconds
  final int onTapDelay;

  /// In Degrees
  final double angle;
  final double scale;
  final double opacity;

  /// Offset is to Transform.translate animation
  final Offset offset;
  final Color highlightColor;
  final Color splashColor;
  @override
  Widget build(BuildContext context) {
    return TapAnimation(
      onTap: onTap,
      angle: angle ?? 0,
      offset: offset ?? Offset.zero,
      opacity: opacity ?? 1,
      scale: scale ?? 1,
      delay: Duration(milliseconds: onTapDelay),
      curve: curve,
      duration: duration,
      builder: (context, child, tapped) => builder(tapped, 1),
      highlightColor: highlightColor,
      splashColor: splashColor,
      child: child,
    );
  }
}
