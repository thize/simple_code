part of simple_code;

class SContainerStyle {
  SContainerStyle({
    this.borderRadius,
    this.margin,
    this.padding,
    this.matrix4,
    this.transform,
    this.width,
    this.elevation,
    this.height,
    this.color,
    this.gradient,
    this.alignmentExternal,
    this.alignment,
    this.border,
    this.positioned,
    this.decorationImage,
    this.shadows = const [],
    this.expanded = false,
    this.circle = false,
    this.animated = false,
    this.animation = const SAnimation(),
  })  : assert(transform?.animated ?? [] != null ?? true),
        assert(circle != null),
        assert(expanded != null),
        assert(positioned?.animated ?? [] != null ?? true),
        assert(animated != null);
  final SAnimation animation;
  final bool animated;
  final double width;
  final double height;
  final SElevation elevation;
  final Color color;
  final Gradient gradient;
  final Alignment alignmentExternal;
  final Alignment alignment;
  final BoxBorder border;
  final bool circle;
  final bool expanded;
  final SPositioned positioned;
  final STransform transform;
  final SEdgeInsets margin;
  final SEdgeInsets padding;
  final Matrix4 matrix4;
  final BorderRadiusGeometry borderRadius;
  final List<SShadow> shadows;
  final DecorationImage decorationImage;
}
