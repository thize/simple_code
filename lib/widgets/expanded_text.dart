part of simple_code;

class ExpandedText extends StatefulWidget {
  const ExpandedText(
    this.data, {
    Key key,
    this.style,
    this.strutStyle,
    this.minFontSize = 1,
    this.maxFontSize = double.maxFinite,
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
  })  : assert(data != null,
            'A non-null String must be provided to a ExpandedText widget.'),
        textSpan = null,
        super(key: key);
  const ExpandedText.rich(
    this.textSpan, {
    Key key,
    this.style,
    this.strutStyle,
    this.minFontSize = 1,
    this.maxFontSize = double.maxFinite,
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
  })  : assert(textSpan != null,
            'A non-null TextSpan must be provided to a ExpandedText.rich widget.'),
        data = null,
        super(key: key);
  final String data;
  final TextSpan textSpan;
  final TextStyle style;
  final StrutStyle strutStyle;
  final double minFontSize;
  final double maxFontSize;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Locale locale;
  final bool softWrap;
  final bool wrapWords;
  final TextOverflow overflow;
  final Widget overflowReplacement;
  final double textScaleFactor;
  final int maxLines;
  final String semanticsLabel;

  @override
  ExpandedTextState createState() => ExpandedTextState();
}

class ExpandedTextState extends State<ExpandedText> {
  double maxFontSize;
  double minFontSize;
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
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    minFontSize = widget.minFontSize.toInt().toDouble();
    maxFontSize = widget.maxFontSize.toInt().toDouble();
    if (maxFontSize <= minFontSize) {
      minFontSize = maxFontSize - 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);

      TextStyle style = widget.style;
      if (widget.style == null || widget.style.inherit) {
        style = defaultTextStyle.style.merge(widget.style);
      }

      style = style.copyWith(fontSize: maxFontSize);

      var maxLines = widget.maxLines ?? defaultTextStyle.maxLines;

      _sanityCheck(style, maxLines);

      var result = _calculateFontSize(size, style, maxLines);
      var fontSize = result[0];
      var textFits = result[1];

      Text text;

      text = _buildText(fontSize, style, maxLines);

      if (widget.overflowReplacement != null && !textFits) {
        return widget.overflowReplacement;
      } else {
        return text;
      }
    });
  }

  void _sanityCheck(TextStyle style, int maxLines) {
    assert(widget.overflow == null || widget.overflowReplacement == null,
        'Either overflow or overflowReplacement have to be null.');
    assert(maxLines == null || maxLines > 0,
        'MaxLines has to be grater than or equal to 1.');

    assert(stepGranularity >= 0.1,
        'StepGranularity has to be greater than or equal to 0.1. It is not a good idea to resize the font with a higher accuracy.');
    assert(
        minFontSize >= 0, 'MinFontSize has to be greater than or equal to 0.');
    assert(maxFontSize > 0, 'MaxFontSize has to be greater than 0.');
    assert(minFontSize <= maxFontSize,
        'MinFontSize has to be smaller or equal than maxFontSize.');
    assert(minFontSize / stepGranularity % 1 == 0,
        'MinFontSize has to be multiples of stepGranularity.');
    if (maxFontSize != double.maxFinite) {
      assert(maxFontSize / stepGranularity % 1 == 0,
          'MaxFontSize has to be multiples of stepGranularity.');
    }
    assert(style.fontSize / stepGranularity % 1 == 0,
        'FontSize has to be multiples of stepGranularity.');
  }

  List _calculateFontSize(BoxConstraints size, TextStyle style, int maxLines) {
    var span = TextSpan(
      style: widget.textSpan?.style ?? style,
      text: widget.textSpan?.text ?? widget.data,
      children: widget.textSpan?.children,
      recognizer: widget.textSpan?.recognizer,
    );

    int left;
    int right;

    left = (minFontSize / stepGranularity).round();
    var initialFontSize = style.fontSize.clamp(minFontSize, maxFontSize);
    right = (initialFontSize / stepGranularity).round();

    var userScale =
        widget.textScaleFactor ?? MediaQuery.textScaleFactorOf(context);

    bool _testValue(int value) {
      double scale;
      scale = value * userScale * stepGranularity / style.fontSize;

      return _checkTextFits(span, scale, maxLines, size);
    }

    bool lastValueFits = false;
    if (_testValue(right)) {
      lastValueFits = true;
    } else {
      right -= 1;
      while (left <= right) {
        int mid = (left + (right - left) / 2).toInt();
        if (_testValue(mid)) {
          left = mid + 1;
          lastValueFits = true;
        } else {
          right = mid - 1;
        }
      }

      if (!lastValueFits) {
        right += 1;
      }
    }

    double fontSize;
    fontSize = right * userScale * stepGranularity;

    return [fontSize, lastValueFits];
  }

  bool _checkTextFits(
      TextSpan text, double scale, int maxLines, BoxConstraints constraints) {
    if (!widget.wrapWords) {
      var wordCount = text.toPlainText().split(RegExp('\\s+')).length;
      if (maxLines == null) {
        maxLines = wordCount;
      } else {
        maxLines = maxLines.clamp(1, wordCount);
      }
    }

    var tp = TextPainter(
      text: text,
      textAlign: widget.textAlign ?? TextAlign.left,
      textDirection: widget.textDirection ?? TextDirection.ltr,
      textScaleFactor: scale ?? 1,
      maxLines: maxLines,
      locale: widget.locale,
      strutStyle: widget.strutStyle,
    );

    tp.layout(maxWidth: constraints.maxWidth);

    return !(tp.didExceedMaxLines ||
        tp.height > constraints.maxHeight ||
        tp.width > constraints.maxWidth);
  }

  Widget _buildText(double fontSize, TextStyle style, int maxLines) {
    if (widget.data != null) {
      return Text(
        widget.data,
        style: style.copyWith(fontSize: fontSize),
        strutStyle: widget.strutStyle,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        locale: widget.locale,
        softWrap: widget.softWrap,
        overflow: widget.overflow,
        textScaleFactor: 1,
        maxLines: maxLines,
        semanticsLabel: widget.semanticsLabel,
      );
    } else {
      return Text.rich(
        widget.textSpan,
        style: style,
        strutStyle: widget.strutStyle,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        locale: widget.locale,
        softWrap: widget.softWrap,
        overflow: widget.overflow,
        textScaleFactor: fontSize / style.fontSize,
        maxLines: maxLines,
        semanticsLabel: widget.semanticsLabel,
      );
    }
  }
}
