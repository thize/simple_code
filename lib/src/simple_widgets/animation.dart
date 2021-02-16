part of simple_code;

enum AnimationTyoe { normal, loop, mirror }

class AnimationWidget extends StatelessWidget {
  const AnimationWidget({
    @required this.child,
    this.type = AnimationTyoe.normal,
    Key key,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.curve = Curves.fastOutSlowIn,
    this.angle = 0,
    this.scale = 1,
    this.opacity = 1,
    this.reversed = false,
    this.builder,
    this.offset = const Offset(0, 0),
  }) : super(key: key);

  final Duration duration;
  final Duration delay;
  final Curve curve;

  final Widget child;

  final AnimationTyoe type;

  final double angle;
  final double scale;
  final double opacity;
  final Offset offset;
  final bool reversed;

  final Widget Function(
      BuildContext context, double animationValue, Widget child) builder;

  @override
  Widget build(BuildContext context) {
    return _buildDoubleAnimation(
      child: child,
      start: opacity, // ! Opacity
      end: 1,
      builder: (child, value) {
        return Opacity(
          opacity: value,
          child: _buildDoubleAnimation(
            child: child,
            start: scale, // ! Scale
            end: 1,
            builder: (child, value) {
              return Transform.scale(
                scale: value,
                child: _buildDoubleAnimation(
                  child: child,
                  start: angle, // ! Angle
                  end: 0,
                  builder: (child, value) {
                    return Transform.rotate(
                      angle: value.degrees,
                      child: _buildDoubleAnimation(
                        child: child,
                        start: offset.dx, // ! Dx Offset
                        end: 0,
                        builder: (child, dx) {
                          return _buildDoubleAnimation(
                            child: child,
                            start: offset.dy, // ! Dy Offset
                            end: 0,
                            builder: (child, dy) {
                              return Transform.translate(
                                offset: Offset(dx, dy),
                                child: _buildDoubleAnimation(
                                  child: child,
                                  start: 1, // ! Builder
                                  end: 0,
                                  builder: (child, animationValue) {
                                    if (builder != null) {
                                      builder(context, animationValue, child);
                                    }
                                    return child;
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
          ),
        );
      },
    );
  }

  Widget _buildDoubleAnimation({
    @required Widget child,
    @required double start,
    @required double end,
    @required Widget Function(Widget widget, double value) builder,
  }) {
    final double auxStart = reversed ? end : start;
    final double auxEnd = reversed ? start : end;
    switch (type) {
      case AnimationTyoe.mirror:
        return MirrorAnimation<double>(
          builder: (_, c, v) => builder(c, v),
          tween: auxStart.tweenTo(auxEnd),
          curve: curve,
          duration: duration,
          child: child,
        );
      case AnimationTyoe.loop:
        return LoopAnimation<double>(
          builder: (_, c, v) => builder(c, v),
          tween: auxStart.tweenTo(auxEnd),
          curve: curve,
          duration: duration,
          child: child,
        );
      default:
        return PlayAnimation<double>(
          builder: (_, c, v) => builder(c, v),
          tween: auxStart.tweenTo(auxEnd),
          curve: curve,
          delay: delay,
          duration: duration,
          child: child,
        );
    }
  }
}
