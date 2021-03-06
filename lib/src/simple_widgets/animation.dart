part of simple_code;

enum AnimationType { normal, loop, mirror }

class AnimationWidget extends StatefulWidget {
  const AnimationWidget({
    this.child,
    this.type = AnimationType.normal,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.curve = Curves.fastOutSlowIn,
    this.angle = 0,
    this.scale = 1,
    this.opacity = 1,
    this.reversed = false,
    this.builder,
    this.offset = const Offset(0, 0),
    this.scaleAlignment = Alignment.center,
    this.rotationAlignment = Alignment.center,
    this.developerMode = false,
    Key? key,
  })  : assert(child != null || builder != null),
        super(key: key);

  final Duration duration;
  final Duration delay;
  final Curve curve;

  final Widget? child;

  final AnimationType type;

  final double angle;
  final double scale;
  final double opacity;
  final Offset offset;
  final bool reversed;
  final bool developerMode;
  final Alignment scaleAlignment;
  final Alignment rotationAlignment;

  final Widget Function(
      BuildContext context, double animationValue, Widget? child)? builder;

  @override
  _AnimationWidgetState createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget> {
  var _reverseType = CustomAnimationControl.PLAY_REVERSE;

  @override
  void initState() {
    super.initState();
    if (widget.reversed) {
      _reverseType = CustomAnimationControl.PLAY_REVERSE_FROM_END;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildDoubleAnimation(
      child: widget.child,
      start: widget.scale, // ! Scale
      end: 1,
      builder: (context, child, value) {
        return Transform.scale(
          scale: value,
          alignment: widget.scaleAlignment,
          child: _buildDoubleAnimation(
            child: child,
            start: widget.angle, // ! Angle
            end: 0,
            builder: (context, child, value) {
              return Transform.rotate(
                angle: value.degrees,
                alignment: widget.rotationAlignment,
                child: _buildDoubleAnimation(
                  child: child,
                  start: widget.offset.dx, // ! Dx Offset
                  end: 0,
                  builder: (context, child, dx) {
                    return _buildDoubleAnimation(
                      child: child,
                      start: widget.offset.dy, // ! Dy Offset
                      end: 0,
                      builder: (context, child, dy) {
                        return Transform.translate(
                          offset: Offset(dx, dy),
                          child: _buildDoubleAnimation(
                            child: child,
                            start: 1, // ! Builder
                            end: 0,
                            builder: (context, child, animationValue) {
                              final result = widget.builder
                                      ?.call(context, animationValue, child) ??
                                  child;
                              if (widget.opacity != 1) {
                                return _AnimatedOpacity(
                                  duration: widget.duration,
                                  curve: widget.curve,
                                  opacity: widget.opacity,
                                  reversed: widget.reversed,
                                  delay: widget.delay,
                                  child: result!,
                                );
                              }
                              return result!;
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildDoubleAnimation({
    required Widget? child,
    required double start,
    required double end,
    required Widget Function(BuildContext context, Widget? widget, double value)
        builder,
  }) {
    switch (widget.type) {
      case AnimationType.mirror:
        return MirrorAnimation<double>(
          fps: SimpleCode._fps,
          builder: (c, w, v) => builder(c, w, v),
          tween: start.tweenTo(end),
          curve: widget.curve,
          duration: widget.duration,
          developerMode: widget.developerMode,
          child: child,
        );
      case AnimationType.loop:
        return LoopAnimation<double>(
          fps: SimpleCode._fps,
          builder: (c, w, v) => builder(c, w, v),
          tween: start.tweenTo(end),
          curve: widget.curve,
          duration: widget.duration,
          developerMode: widget.developerMode,
          child: child,
        );
      default:
        return CustomAnimation<double>(
          fps: SimpleCode._fps,
          builder: (c, w, v) => builder(c, w, v),
          tween: start.tweenTo(end),
          curve: widget.curve,
          delay: widget.delay,
          duration: widget.duration,
          control: widget.reversed ? _reverseType : CustomAnimationControl.PLAY,
          developerMode: widget.developerMode,
          child: child,
        );
    }
  }
}

class _AnimatedOpacity extends StatefulWidget {
  const _AnimatedOpacity({
    required this.opacity,
    required this.duration,
    required this.delay,
    required this.curve,
    required this.child,
    required this.reversed,
    Key? key,
  }) : super(key: key);

  final double opacity;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final Widget child;
  final bool reversed;

  @override
  __AnimatedOpacityState createState() => __AnimatedOpacityState();
}

class __AnimatedOpacityState extends State<_AnimatedOpacity> {
  double value = 0;

  @override
  void initState() {
    super.initState();
    value = widget.opacity;
    runAnimation(withDelay: true);
  }

  @override
  void didUpdateWidget(_AnimatedOpacity oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.reversed != widget.reversed) {
      runAnimation(withDelay: false);
    }
  }

  void runAnimation({required bool withDelay}) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      if (withDelay) await Future.delayed(widget.delay);
      value = widget.reversed ? widget.opacity : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: value,
      duration: widget.duration,
      curve: widget.curve,
      child: widget.child,
    );
  }
}
