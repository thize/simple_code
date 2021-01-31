part of simple_code;

/// Extension Methods & Widgets for the numbers
extension NumExtension on num {
  ///
  /// Use this extension method to get
  /// fixed values after decimal with defined length.
  ///
  String toDoubleStringAsFixed({int digit = 2}) =>
      toStringAsFixed(truncateToDouble() == this ? 0 : digit);

  ///
  /// Use this extension method to get
  /// precised values after decimal with defined length.
  ///
  String toDoubleStringAsPrecised({int length = 4}) {
    return ((this * pow(10, length)).truncateToDouble() / pow(10, length))
        .toString();
  }

  ///
  /// Check if the number is null
  ///
  bool get isNull => this == null;

  ///
  /// Check if the number is not null
  ///
  bool get isNotNull => this != null;

  /// Returns if the number is even
  bool get isEven => this % 2 == 0;

  /// Returns if the number is odd
  bool get isOdd => this % 2 != 0;

  /// Returns if the number is positive
  bool get isPositive => this > 0;

  /// Returns if the number is negative
  bool get isNegative => this < 0;

  double get a => SimpleCode._apply(toDouble());

  double get wsz => SimpleCode._wsz(toDouble());

  double get sz => SimpleCode._sz(toDouble());

  double get hsz => SimpleCode._hsz(toDouble());

  double get degrees => toDouble() * pi / 180;

  //! Widgets

  Tween<double> tweenTo(double end) =>
      Tween<double>(begin: toDouble(), end: end);

  Spacer get spacer => Spacer(flex: toInt());

  /// Get Text Widget for the String
  Text get text => Text(toString());
}

/// Extension method for integers.
extension IntExtension on int {
  int get random => Random().nextInt(this);

  List<Widget> builder(Widget Function(int index) element) {
    final List<Widget> widgets = [];
    for (var i = 0; i < this; i++) {
      widgets.add(element(i));
    }
    return widgets;
  }
}
