part of simple_code;

/// Extension for general basic [Context]
extension ContextExtension on BuildContext {
  /// To get a [MediaQuery] directly.
  MediaQueryData get mq => MediaQuery.of(this);

  /// Get MediaQuery Screen Size
  Size get size => mq.size;

  /// Get MediaQuery Screen Padding
  EdgeInsets get padding => mq.padding;

  /// Get MediaQuery Screen Width
  double get width => mq.size.width;

  /// Get MediaQuery Screen Height
  double get height => mq.size.height;

  ///Returns Orientation using [MediaQuery]
  Orientation get orientation => mq.orientation;

  /// Extension for getting Theme
  ThemeData get theme => Theme.of(this);

  /// Extension for getting textTheme
  TextTheme get textTheme => theme.textTheme;

  ///
  /// The default brightness of the [Theme].
  ///
  Brightness get brightness => theme.brightness;

  bool get isDark => brightness == Brightness.dark;

  /// Returns The state from the closest instance of this class
  /// that encloses the given context.
  /// It is used for validating forms
  FormState get form => Form.of(this);

  ///
  /// Returns The current [Locale] of the app as specified in
  /// the [Localizations] widget.
  ///
  Locale get locale => Localizations.localeOf(this);

  /// Returns The state from the closest instance of this class
  /// that encloses the given context.
  ///
  /// It is used for showing widgets on top of everything.
  ///
  OverlayState get overlay => Overlay.of(this);

  ///
  /// Insert the given widget into the overlay.
  /// The newly inserted widget will always be at the top.
  ///
  OverlayEntry addOverlay(WidgetBuilder builder) {
    final entry = OverlayEntry(builder: builder);
    overlay.insert(entry);
    return entry;
  }

  ///
  /// Returns the closest instance of [ScaffoldState] in the widget tree,
  /// which can be use to get information about that scaffold.
  ///
  /// If there is no [Scaffold] in scope, then this will throw an exception.
  ///
  ScaffoldState get scaffold => Scaffold.of(this);

  ///
  /// Shows a [SnackBar] at the bottom of the scaffold.
  ///
  /// If you call this function too quickly, the new snackbar is added to a
  /// queue and displayed when the current one disappears.
  ///
  void showSnackBar(SnackBar snackbar) =>
      ScaffoldMessenger.of(this).showSnackBar(snackbar);
}
