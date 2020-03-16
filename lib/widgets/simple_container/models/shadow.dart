part of simple_code;

class SShadow {
  SShadow({this.color, this.blurRadius = 6, this.dx = 0, this.dy = 3});

  final Color color;
  final double blurRadius;
  final double dx;
  final double dy;

  BoxShadow build() {
    return BoxShadow(
      blurRadius: blurRadius,
      color: color ?? Colors.black.withOpacity(0.16),
      offset: Offset(dx, dy),
    );
  }
}
