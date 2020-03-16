part of simple_code;

class SGestures {
  SGestures({
    this.animations,
    this.onChanged,
    this.onTapDown,
    this.onTapUp,
    this.onTap,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onDoubleTap,
    this.onLongPress,
    this.onLongPressStart,
    this.onLongPressMoveUpdate,
    this.onLongPressUp,
    this.onLongPressEnd,
    this.onVerticalDragDown,
    this.onVerticalDragStart,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.onVerticalDragCancel,
    this.onHorizontalDragDown,
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.onHorizontalDragCancel,
    this.onPanDown,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.onPanCancel,
    this.onScaleStart,
    this.onScaleUpdate,
    this.onScaleEnd,
    this.onForcePressStart,
    this.onForcePressPeak,
    this.onForcePressUpdate,
    this.onForcePressEnd,
    this.behavior,
    this.excludeFromSemantics = false,
    this.dragStartBehavior = DragStartBehavior.start,
  });
  final SGesturesAnimation animations;
  final GestureTapDownCallback onTapDown;
  final GestureTapUpCallback onTapUp;
  final GestureTapCallback onTap;
  final GestureTapCancelCallback onTapCancel;
  final GestureTapDownCallback onSecondaryTapDown;
  final GestureTapUpCallback onSecondaryTapUp;
  final GestureTapCancelCallback onSecondaryTapCancel;
  final GestureTapCallback onDoubleTap;
  final GestureLongPressCallback onLongPress;
  final GestureLongPressStartCallback onLongPressStart;
  final GestureLongPressMoveUpdateCallback onLongPressMoveUpdate;
  final GestureLongPressUpCallback onLongPressUp;
  final GestureLongPressEndCallback onLongPressEnd;
  final GestureDragDownCallback onVerticalDragDown;
  final GestureDragStartCallback onVerticalDragStart;
  final GestureDragUpdateCallback onVerticalDragUpdate;
  final GestureDragEndCallback onVerticalDragEnd;
  final GestureDragCancelCallback onVerticalDragCancel;
  final GestureDragDownCallback onHorizontalDragDown;
  final GestureDragStartCallback onHorizontalDragStart;
  final GestureDragUpdateCallback onHorizontalDragUpdate;
  final GestureDragEndCallback onHorizontalDragEnd;
  final GestureDragCancelCallback onHorizontalDragCancel;
  final GestureDragDownCallback onPanDown;
  final GestureDragStartCallback onPanStart;
  final GestureDragUpdateCallback onPanUpdate;
  final GestureDragEndCallback onPanEnd;
  final GestureDragCancelCallback onPanCancel;
  final GestureScaleStartCallback onScaleStart;
  final GestureScaleUpdateCallback onScaleUpdate;
  final GestureScaleEndCallback onScaleEnd;
  final GestureForcePressStartCallback onForcePressStart;
  final GestureForcePressPeakCallback onForcePressPeak;
  final GestureForcePressUpdateCallback onForcePressUpdate;
  final GestureForcePressEndCallback onForcePressEnd;
  final HitTestBehavior behavior;
  final bool excludeFromSemantics;
  final DragStartBehavior dragStartBehavior;
  final void Function(bool tapped) onChanged;

  Widget build(Widget child) {
    return _SGestureWidget(sGestures: this, child: child);
  }
}

class SGesturesAnimation {
  SGesturesAnimation({
    this.animation = const SAnimation(),
    this.angle,
    this.scale,
    this.opacity,
    this.dx,
    this.dy,
    this.onTapDelay = 0,
  });

  final SAnimation animation;

  /// On Tap Delay in milliseconds
  final int onTapDelay;

  /// In Degrees
  final double angle;
  final double scale;
  final double opacity;

  /// Offset is to Transform.translate animation
  final double dx;
  final double dy;

  Widget build({@required Widget child, @required bool tapped}) {
    return AnimatedTween(
      angle: angle,
      child: child,
      curve: animation.curve,
      duration: Duration(milliseconds: animation.milliseconds),
      offset: dx != null || dy != null ? Offset(dx ?? 0, dy ?? 0) : null,
      opacity: opacity,
      scale: scale,
      stopped: tapped,
    );
  }
}

class _SGestureWidget extends StatefulWidget {
  _SGestureWidget({Key key, @required this.sGestures, @required this.child})
      : super(key: key);
  final SGestures sGestures;
  final Widget child;

  @override
  __SGestureWidgetState createState() => __SGestureWidgetState();
}

class __SGestureWidgetState extends State<_SGestureWidget> {
  bool _tapped = false;
  void onTapChange(bool value) async {
    if (!value) {
      await Future.delayed(Duration(
          milliseconds: widget.sGestures?.animations?.onTapDelay ?? 0));
    }
    setState(() => _tapped = value);
    widget.sGestures.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails tapDownDetails) {
        onTapChange(true);
        if (widget.sGestures.onTapDown != null) {
          widget.sGestures.onTapDown(tapDownDetails);
        }
      },
      onTapUp: (TapUpDetails tapUpDetails) {
        onTapChange(false);
        if (widget.sGestures.onTapUp != null) {
          widget.sGestures.onTapUp(tapUpDetails);
        }
      },
      onTapCancel: () {
        onTapChange(false);
        if (widget.sGestures.onTapCancel != null) {
          widget.sGestures.onTapCancel();
        }
      },
      onTap: widget.sGestures.onTap,
      onDoubleTap: widget.sGestures.onDoubleTap,
      onLongPress: widget.sGestures.onLongPress,
      onLongPressStart: widget.sGestures.onLongPressStart,
      onLongPressEnd: widget.sGestures.onLongPressEnd,
      onLongPressMoveUpdate: widget.sGestures.onLongPressMoveUpdate,
      onLongPressUp: widget.sGestures.onLongPressUp,
      onVerticalDragStart: widget.sGestures.onVerticalDragStart,
      onVerticalDragEnd: widget.sGestures.onVerticalDragEnd,
      onVerticalDragDown: widget.sGestures.onVerticalDragDown,
      onVerticalDragCancel: widget.sGestures.onVerticalDragCancel,
      onVerticalDragUpdate: widget.sGestures.onVerticalDragUpdate,
      onHorizontalDragStart: widget.sGestures.onHorizontalDragStart,
      onHorizontalDragEnd: widget.sGestures.onHorizontalDragEnd,
      onHorizontalDragCancel: widget.sGestures.onHorizontalDragCancel,
      onHorizontalDragUpdate: widget.sGestures.onHorizontalDragUpdate,
      onHorizontalDragDown: widget.sGestures.onHorizontalDragDown,
      onForcePressStart: widget.sGestures.onForcePressStart,
      onForcePressEnd: widget.sGestures.onForcePressEnd,
      onForcePressPeak: widget.sGestures.onForcePressPeak,
      onForcePressUpdate: widget.sGestures.onForcePressUpdate,
      onPanStart: widget.sGestures.onPanStart,
      onPanEnd: widget.sGestures.onPanEnd,
      onPanCancel: widget.sGestures.onPanCancel,
      onPanDown: widget.sGestures.onPanDown,
      onPanUpdate: widget.sGestures.onPanUpdate,
      onScaleStart: widget.sGestures.onScaleStart,
      onScaleEnd: widget.sGestures.onScaleEnd,
      onScaleUpdate: widget.sGestures.onScaleUpdate,
      behavior: widget.sGestures.behavior,
      excludeFromSemantics: widget.sGestures.excludeFromSemantics,
      dragStartBehavior: widget.sGestures.dragStartBehavior,
      child: widget.sGestures?.animations
              ?.build(child: widget.child, tapped: _tapped) ??
          widget.child,
      onSecondaryTapCancel: widget.sGestures.onSecondaryTapCancel,
      onSecondaryTapDown: widget.sGestures.onSecondaryTapDown,
      onSecondaryTapUp: widget.sGestures.onSecondaryTapUp,
    );
  }
}
