part of simple_code;

class SEdgeInsets {
  SEdgeInsets({
    this.all,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.vertical,
    this.horizontal,
  });
  final double all;
  final double left;
  final double top;
  final double right;
  final double bottom;
  final double vertical;
  final double horizontal;

  EdgeInsets build() {
    double l = left ?? horizontal ?? all ?? 0;
    double t = top ?? vertical ?? all ?? 0;
    double r = right ?? horizontal ?? all ?? 0;
    double b = bottom ?? vertical ?? all ?? 0;
    return EdgeInsets.fromLTRB(l, t, r, b);
  }
}
