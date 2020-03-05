part of simple_code;

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({
    Key key,
    @required this.onTap,
    this.child,
    this.builder,
    this.duration = const Duration(milliseconds: 800),
    this.onTapDelay = 0,
    this.curve = Curves.easeOutCirc,
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
  final Widget Function(bool tapped) builder;
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
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool tapped = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedTween(
      angle: widget.angle,
      curve: widget.curve,
      duration: widget.duration,
      offset: widget.offset,
      opacity: widget.opacity,
      scale: widget.scale,
      stopped: tapped,
      child: InkWell(
        onTapDown: _onTapDown,
        onTap: _onTap,
        onTapCancel: _onTapCancel,
        highlightColor: widget.highlightColor,
        splashColor: widget.splashColor,
        child: widget.child ?? widget.builder(tapped),
      ),
    );
  }

  void Function(TapDownDetails) get _onTapDown =>
      (va) => setState(() => tapped = true);

  void Function() get _onTapCancel => () => setState(() => tapped = false);

  dynamic get _onTap => widget.onTap == null
      ? null
      : () async {
          await Future.delayed(Duration(milliseconds: widget.onTapDelay));
          setState(() => tapped = false);
          widget.onTap();
        };
}
