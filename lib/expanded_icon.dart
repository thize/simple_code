part of simple_code;

class ExpandedIcon extends StatelessWidget {
  final IconData icon;
  final double maxSize;
  final double minSize;
  final Color color;
  final String semanticLabel;
  final TextDirection textDirection;
  const ExpandedIcon(
    this.icon, {
    Key key,
    this.color,
    this.semanticLabel,
    this.textDirection,
    this.maxSize = double.maxFinite,
    this.minSize = 2.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double size = min(constraints.maxHeight, constraints.maxWidth);
        if (size < minSize) {
          size = minSize;
        } else if (size > maxSize) {
          size = maxSize;
        }
        return new Icon(
          icon,
          color: color,
          key: key,
          semanticLabel: semanticLabel,
          textDirection: textDirection,
          size: SimpleCode._size(size),
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection));
  }
}
