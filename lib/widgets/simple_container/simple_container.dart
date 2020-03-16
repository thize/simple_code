part of simple_code;

class SContainer extends StatelessWidget {
  const SContainer({Key key, this.child, this.style, this.gestures})
      : super(key: key);
  final Widget child;
  final SContainerStyle style;
  final SGestures gestures;

  Widget _externalAlignment(Widget child) {
    if (style.alignmentExternal != null) {
      return Align(alignment: style.alignmentExternal, child: child);
    }
    return child;
  }

  Widget _transform(Widget child) {
    if (style.transform != null) {
      return style.transform.build(style: style, child: child);
    }
    return child;
  }

  Widget _expanded(Widget child) {
    if (style.expanded) {
      return Expanded(child: child);
    }
    return child;
  }
  
  Widget _positioned(Widget child) {
    if (style.positioned != null) {
      return style.positioned.build(child: child, style: style);
    }
    return child;
  }

  Widget _gestures(Widget child) {
    if (gestures != null) {
      return gestures.build(child);
    }
    return child;
  }

  Widget _container() {
    if (style.animated) {
      return style.animation.build(child: child, style: style);
    }
    return Container(
      child: child,
      width: style.width,
      key: key,
      alignment: style.alignment,
      height: style.height,
      margin: style?.margin?.build(),
      padding: style?.padding?.build(),
      transform: style.matrix4,
      decoration: BoxDecoration(
        gradient: style.gradient,
        color: style.color,
        border: style.border,
        image: style.decorationImage,
        shape: style.circle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: style.circle ? null : style.borderRadius,
        boxShadow: [
          if (style.elevation != null) style.elevation?._boxShadow,
          ..._buildShadow(),
        ],
      ),
    );
  }

  List<BoxShadow> _buildShadow() {
    List<BoxShadow> shadows = [];
    style?.shadows?.forEach((shadow) {
      shadows.add(shadow.build());
    });
    return shadows;
  }

  @override
  Widget build(BuildContext context) {
    return _positioned(
      _expanded(
        _externalAlignment(
          _transform(
            _gestures(
              _container(),
            ),
          ),
        ),
      ),
    );
  }
}
