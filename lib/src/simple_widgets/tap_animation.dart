part of simple_code;

class TapAnimation extends StatefulWidget {
  const TapAnimation({
    @required this.onTap,
    this.child,
    this.builder,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.curve = Curves.fastOutSlowIn,
    this.angle,
    this.opacity,
    this.scale,
    this.offset,
    this.highlightColor,
    this.splashColor,
    Key key,
  })  : assert(opacity == null || opacity >= 0 && opacity <= 1),
        assert(child != null || builder != null),
        super(key: key);

  final void Function() onTap;
  final Widget child;
  final Widget Function(BuildContext context, Widget child, bool tapped)
      builder;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final double angle;
  final double opacity;
  final double scale;
  final Offset offset;
  final Color highlightColor;
  final Color splashColor;

  @override
  _TapAnimationState createState() => _TapAnimationState();
}

class _TapAnimationState extends State<TapAnimation> {
  bool _tapped = false;

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;
    if (_tapped) {
      child = AnimationWidget(
        child,
        angle: widget.angle,
        curve: widget.curve,
        duration: widget.duration,
        offset: widget.offset,
        opacity: widget.opacity,
        scale: widget.scale,
        reversed: true,
      );
    }
    return InkWell(
      onTapDown: _onTapDown,
      onTap: _onTap,
      onTapCancel: _onTapCancel,
      highlightColor: widget.highlightColor,
      splashColor: widget.splashColor,
      child: widget.builder != null
          ? widget.builder(context, child, _tapped)
          : child,
    );
  }

  void _onTap() {
    widget.delay.delay.whenComplete(() {
      setState(() => _tapped = false);
      widget.onTap();
    });
  }

  void _onTapDown(TapDownDetails details) {
    setState(() => _tapped = true);
  }

  void _onTapCancel() {
    setState(() => _tapped = false);
  }
}
