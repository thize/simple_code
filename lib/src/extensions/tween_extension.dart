part of simple_code;

extension ColorExtension on Color {
  /// Returns a [ColorTween] from [this] color to the given [end] color
  ///
  ColorTween tweenTo(Color end) {
    return ColorTween(begin: this, end: end);
  }
}

extension OffsetExtension on Offset {
  /// Returns a [Tween<Offset>] from [this] value to the given [end] value
  ///
  Tween<Offset> tweenTo(Offset end) {
    return Tween<Offset>(begin: this, end: end);
  }
}
