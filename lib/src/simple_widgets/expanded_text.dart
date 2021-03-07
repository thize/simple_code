part of simple_code;

class ExpandedText extends StatefulWidget {
  /// Creates a [ExpandedText] widget.
  ///
  /// If the [style] argument is null, the text will use the style from the
  /// closest enclosing [DefaultTextStyle].
  const ExpandedText(
    String this.data, {
    Key? key,
    this.textKey,
    this.style,
    this.strutStyle,
    this.minFontSize = 1,
    this.maxFontSize = double.maxFinite,
    this.stepGranularity = 1,
    this.presetFontSizes,
    this.group,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.wrapWords = true,
    this.overflow,
    this.overflowReplacement,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
  })  : textSpan = null,
        super(key: key);

  const ExpandedText.rich(
    TextSpan this.textSpan, {
    Key? key,
    this.textKey,
    this.style,
    this.strutStyle,
    this.minFontSize = 12,
    this.maxFontSize = double.infinity,
    this.stepGranularity = 1,
    this.presetFontSizes,
    this.group,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.wrapWords = true,
    this.overflow,
    this.overflowReplacement,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
  })  : data = null,
        super(key: key);

  /// Sets the key for the resulting [Text] widget.
  ///
  /// This allows you to find the actual `Text` widget built by `AutoSizeText`.
  final Key? textKey;

  /// The text to display.
  ///
  /// This will be null if a [textSpan] is provided instead.
  final String? data;

  /// The text to display as a [TextSpan].
  ///
  /// This will be null if [data] is provided instead.
  final TextSpan? textSpan;

  /// If non-null, the style to use for this text.
  ///
  /// If the style's "inherit" property is true, the style will be merged with
  /// the closest enclosing [DefaultTextStyle]. Otherwise, the style will
  /// replace the closest enclosing [DefaultTextStyle].
  final TextStyle? style;

  /// The strut style to use. Strut style defines the strut, which sets minimum
  /// vertical layout metrics.
  ///
  /// Omitting or providing null will disable strut.
  ///
  /// Omitting or providing null for any properties of [StrutStyle] will result
  /// in default values being used. It is highly recommended to at least specify
  /// a font size.
  ///
  /// See [StrutStyle] for details.
  final StrutStyle? strutStyle;

  /// The minimum text size constraint to be used when auto-sizing text.
  ///
  /// Is being ignored if [presetFontSizes] is set.
  final double minFontSize;

  /// The maximum text size constraint to be used when auto-sizing text.
  ///
  /// Is being ignored if [presetFontSizes] is set.
  final double maxFontSize;

  /// The step size in which the font size is being adapted to constraints.
  ///
  /// The Text scales uniformly in a range between [minFontSize] and
  /// [maxFontSize].
  /// Each increment occurs as per the step size set in stepGranularity.
  ///
  /// Most of the time you don't want a stepGranularity below 1.0.
  ///
  /// Is being ignored if [presetFontSizes] is set.
  final double stepGranularity;

  /// Predefines all the possible font sizes.
  ///
  /// **Important:** PresetFontSizes have to be in descending order.
  final List<double>? presetFontSizes;

  /// Synchronizes the size of multiple [AutoSizeText]s.
  ///
  /// If you want multiple [AutoSizeText]s to have the same text size, give all
  /// of them the same [AutoSizeGroup] instance. All of them will have the
  /// size of the smallest [AutoSizeText]
  final AutoSizeGroup? group;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The directionality of the text.
  ///
  /// This decides how [textAlign] values like [TextAlign.start] and
  /// [TextAlign.end] are interpreted.
  ///
  /// This is also used to disambiguate how to render bidirectional text. For
  /// example, if the [data] is an English phrase followed by a Hebrew phrase,
  /// in a [TextDirection.ltr] context the English phrase will be on the left
  /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
  /// context, the English phrase will be on the right and the Hebrew phrase on
  /// its left.
  ///
  /// Defaults to the ambient [Directionality], if any.
  final TextDirection? textDirection;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  final Locale? locale;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was
  /// unlimited horizontal space.
  final bool? softWrap;

  /// Whether words which don't fit in one line should be wrapped.
  ///
  /// If false, the fontSize is lowered as far as possible until all words fit
  /// into a single line.
  final bool wrapWords;

  /// How visual overflow should be handled.
  ///
  /// Defaults to retrieving the value from the nearest [DefaultTextStyle] ancestor.
  final TextOverflow? overflow;

  /// If the text is overflowing and does not fit its bounds, this widget is
  /// displayed instead.
  final Widget? overflowReplacement;

  /// The number of font pixels for each logical pixel.
  ///
  /// For example, if the text scale factor is 1.5, text will be 50% larger than
  /// the specified font size.
  ///
  /// This property also affects [minFontSize], [maxFontSize] and [presetFontSizes].
  ///
  /// The value given to the constructor as textScaleFactor. If null, will
  /// use the [MediaQueryData.textScaleFactor] obtained from the ambient
  /// [MediaQuery], or 1.0 if there is no [MediaQuery] in scope.
  final double? textScaleFactor;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be resized according
  /// to the specified bounds and if necessary truncated according to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  ///
  /// If this is null, but there is an ambient [DefaultTextStyle] that specifies
  /// an explicit number for its [DefaultTextStyle.maxLines], then the
  /// [DefaultTextStyle] value will take precedence. You can use a [RichText]
  /// widget directly to entirely override the [DefaultTextStyle].
  final int? maxLines;

  /// An alternative semantics label for this text.
  ///
  /// If present, the semantics of this widget will contain this value instead
  /// of the actual text. This will overwrite any of the semantics labels applied
  /// directly to the [TextSpan]s.
  ///
  /// This is useful for replacing abbreviations or shorthands with the full
  /// text value:
  ///
  /// ```dart
  /// AutoSizeText(r'$$', semanticsLabel: 'Double dollars')
  /// ```
  final String? semanticsLabel;

  @override
  ExpandedTextState createState() => ExpandedTextState();
}

class ExpandedTextState extends State<ExpandedText> {
  late double maxFontSize;
  late double minFontSize;
  final double stepGranularity = 1;
  @override
  void initState() {
    super.initState();
    minFontSize = widget.minFontSize.toInt().toDouble();
    maxFontSize = widget.maxFontSize.toInt().toDouble();
    if (maxFontSize <= minFontSize) {
      minFontSize = maxFontSize - 1;
    }
  }

  @override
  void didUpdateWidget(ExpandedText oldWidget) {
    super.didUpdateWidget(oldWidget);
    minFontSize = widget.minFontSize.toInt().toDouble();
    maxFontSize = widget.maxFontSize.toInt().toDouble();
    if (maxFontSize <= minFontSize) {
      minFontSize = maxFontSize - 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle =
        widget.style ?? DefaultTextStyle.of(context).style;
    if (widget.data != null) {
      return AutoSizeText(
        widget.data!,
        style: textStyle.copyWith(fontSize: maxFontSize),
        strutStyle: widget.strutStyle,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        locale: widget.locale,
        softWrap: widget.softWrap,
        overflow: widget.overflow,
        textScaleFactor: widget.textScaleFactor,
        maxLines: widget.maxLines,
        semanticsLabel: widget.semanticsLabel,
        group: widget.group,
        maxFontSize: maxFontSize,
        minFontSize: minFontSize,
        overflowReplacement: widget.overflowReplacement,
        presetFontSizes: widget.presetFontSizes,
        stepGranularity: widget.stepGranularity,
        textKey: widget.textKey,
        wrapWords: widget.wrapWords,
      );
    }
    return AutoSizeText.rich(
      widget.textSpan!,
      style: textStyle.copyWith(fontSize: maxFontSize),
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      locale: widget.locale,
      softWrap: widget.softWrap,
      overflow: widget.overflow,
      textScaleFactor: widget.textScaleFactor,
      maxLines: widget.maxLines,
      semanticsLabel: widget.semanticsLabel,
      group: widget.group,
      maxFontSize: maxFontSize,
      minFontSize: minFontSize,
      overflowReplacement: widget.overflowReplacement,
      presetFontSizes: widget.presetFontSizes,
      stepGranularity: widget.stepGranularity,
      textKey: widget.textKey,
      wrapWords: widget.wrapWords,
    );
  }
}
