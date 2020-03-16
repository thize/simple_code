part of simple_code;

class SElevation {
  SElevation(
    this.elevation, {
    this.angle = 0.0,
    this.shadowColor = const Color(0x33000000),
    this.opacity = 1.0,
  });
  final double elevation;
  final double angle;
  final Color shadowColor;
  final double opacity;
  double _elevationOpacityCurve(double x) =>
      pow(x, 1 / 16) / sqrt(pow(x, 2) + 2) + 0.2;
  double get _calculatedOpacity => _elevationOpacityCurve(elevation) * opacity;
  BoxShadow get _boxShadow => BoxShadow(
        color: shadowColor.withOpacity(_calculatedOpacity),
        blurRadius: elevation,
        spreadRadius: 0.0,
        offset: Offset(sin(angle) * elevation, cos(angle) * elevation),
      );
}
