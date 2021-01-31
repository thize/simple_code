part of simple_code;

class TapAnimation extends StatefulWidget {
  const TapAnimation({
    @required this.child,
    @required this.onTap,
    @required this.builder,
    @required this.duration,
    @required this.delay,
    @required this.curve,
    @required this.angle,
    @required this.opacity,
    @required this.scale,
    @required this.offset,
    @required this.highlightColor,
    @required this.splashColor,
    Key key,
  }) : super(key: key);

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
