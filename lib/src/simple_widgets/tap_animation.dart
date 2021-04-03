part of simple_code;

class TapAnimation extends StatefulWidget {
  const TapAnimation({
    this.onTap,
    this.child,
    this.builder,
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.easeOutCirc,
    this.delay = Duration.zero,
    this.angle = 0,
    this.opacity = 1,
    this.scale = 1,
    this.offset = Offset.zero,
    this.highlightColor,
    this.splashColor,
    Key? key,
  })  : assert(opacity >= 0 && opacity <= 1),
        assert(child != null || builder != null),
        super(key: key);

  final void Function()? onTap;
  final Widget? child;
  final Widget Function(
          BuildContext context, Widget? child, double animation, bool tapped)?
      builder;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final double angle;
  final double opacity;
  final double scale;
  final Offset offset;
  final Color? highlightColor;
  final Color? splashColor;

  @override
  _TapAnimationState createState() => _TapAnimationState();
}

class _TapAnimationState extends State<TapAnimation> {
  bool _tapped = false;

  @override
  Widget build(BuildContext context) {
    return AnimationWidget(
      angle: widget.angle,
      curve: _tapped ? widget.curve.flipped : widget.curve,
      duration: widget.duration,
      offset: widget.offset,
      opacity: widget.opacity,
      scale: widget.scale,
      reversed: _tapped,
      builder: (context, animation, w) {
        return InkWell(
          onTapDown: _onTapDown,
          onTap: widget.onTap == null ? null : _onTap,
          onTapCancel: _onTapCancel,
          highlightColor: widget.highlightColor,
          splashColor: widget.splashColor,
          child:
              widget.builder?.call(context, widget.child, animation, _tapped) ??
                  widget.child,
        );
      },
    );
  }

  void _onTap() {
    widget.onTap!();
    Future.delayed(widget.delay).whenComplete(() {
      if (mounted) setState(() => _tapped = false);
    });
  }

  void _onTapDown(TapDownDetails details) {
    setState(() => _tapped = true);
  }

  void _onTapCancel() {
    setState(() => _tapped = false);
  }
}
