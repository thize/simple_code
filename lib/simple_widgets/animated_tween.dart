part of simple_code;

class AnimatedTween extends StatefulWidget {
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
  _AnimatedTweenState createState() => _AnimatedTweenState();
}

class _AnimatedTweenState extends State<AnimatedTween> {
  bool inEnd = true;

  Future _initState() async {
    await Future.delayed(widget.delay ?? const Duration());
    if (mounted) {
      setState(() {
        inEnd = widget.inEnd;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildOffset(
      _buildAngle(
        _buildOpacity(
          _buildScale(
            _buildBuilder(),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    inEnd = widget.inEnd;
    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedTween oldWidget) {
    _initState();
    super.didUpdateWidget(oldWidget);
  }

  Widget _buildBuilder() {
    if (widget.builder != null) {
      return _buildTween(
        animationBulder: (Widget child, double animationValue) {
          return widget.builder(context, animationValue, child);
        },
        child: widget.child,
        tween: Tween<double>(begin: 0, end: inEnd ? 0 : 1),
      );
    }
    return widget.child;
  }

  Widget _buildScale(Widget child) {
    if (widget.scale != null) {
      final double begin = widget.scale;
      return _buildTween(
        child: child,
        tween: Tween(begin: begin, end: inEnd ? begin : 1),
        animationBulder: (Widget child, double animationValue) {
          return Transform.scale(
            scale: animationValue,
            child: child,
          );
        },
      );
    }
    return child;
  }

  Widget _buildAngle(Widget child) {
    if (widget.angle != null) {
      final double begin = widget.angle * pi / 180;
      return _buildTween(
        child: child,
        tween: Tween(begin: begin, end: inEnd ? begin : 0),
        animationBulder: (Widget child, double animationValue) {
          return Transform.rotate(
            angle: animationValue,
            child: child,
          );
        },
      );
    }
    return child;
  }

  Widget _buildOpacity(Widget child) {
    if (widget.opacity != null) {
      final double begin = widget.opacity;
      return _buildTween(
        child: child,
        tween: Tween(begin: begin, end: inEnd ? begin : 1),
        animationBulder: (Widget child, double animationValue) {
          return Opacity(
            opacity: animationValue,
            child: child,
          );
        },
      );
    }
    return child;
  }

  Widget _buildOffset(Widget child) {
    if (widget.offset != null) {
      const double begin = 1;
      return _buildTween(
        child: child,
        tween: Tween(begin: begin, end: inEnd ? begin : 0),
        animationBulder: (Widget child, double value) {
          return Transform.translate(
            offset: Offset(widget.offset.dx * value, widget.offset.dy * value),
            child: child,
          );
        },
      );
    }
    return child;
  }

  Widget _buildTween(
      {@required
          Widget Function(Widget child, double animationValue) animationBulder,
      @required
          Widget child,
      @required
          Tween<double> tween}) {
    return TweenAnimationBuilder(
      duration: widget.duration,
      tween: tween,
      curve: widget.curve,
      builder: (_, double value, Widget child) {
        return animationBulder(child, value);
      },
      child: child,
    );
  }
}
