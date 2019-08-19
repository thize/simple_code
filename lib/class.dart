part of simple_code;

class _SimpleCode {
  final double heigthEmulator;
  final double widthEmulator;
  final double heigth;
  final double width;
  _SimpleCode(
      {@required this.heigth,
      @required this.width,
      this.heigthEmulator = 640.0,
      this.widthEmulator = 360.0});
  _expandedIcon(Icon icon,
      {double maxSize = double.maxFinite, double minSize = 2.0}) {
    return new LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double tamanho = min(constraints.maxHeight, constraints.maxWidth);
        if (tamanho < minSize) {
          tamanho = minSize;
        } else if (tamanho > maxSize) {
          tamanho = maxSize;
        }
        return new Icon(
          icon.icon,
          color: icon.color,
          key: icon.key,
          semanticLabel: icon.semanticLabel,
          textDirection: icon.textDirection,
          size: _size(tamanho),
        );
      },
    );
  }

  Widget _expandedText(
    Text textWidget, {
    AutoSizeGroup group,
    double maxFontSize = double.infinity,
    double minFontSize = 6.0,
    Widget overflowReplacement,
    List<double> presetFontSizes,
    double stepGranularity = 1,
    bool wrapWords = true,
  }) {
    TextStyle textStyle = new TextStyle(fontSize: double.maxFinite);
    if (textWidget.style != null) {
      textStyle = textStyle.merge(textWidget.style);
    }
    return new _AutoSizeText(
      textWidget.data,
      overflow: textWidget.overflow,
      key: textWidget.key,
      locale: textWidget.locale,
      maxLines: textWidget.maxLines,
      softWrap: textWidget.softWrap,
      textScaleFactor: textWidget.textScaleFactor,
      style: textStyle,
      strutStyle: textWidget.strutStyle,
      semanticsLabel: textWidget.semanticsLabel,
      textAlign: textWidget.textAlign,
      textDirection: textWidget.textDirection,
      group: group,
      maxFontSize: maxFontSize,
      minFontSize: minFontSize,
      overflowReplacement: overflowReplacement,
      presetFontSizes: presetFontSizes,
      stepGranularity: stepGranularity,
      wrapWords: wrapWords,
    );
  }

  _size(double size, {bool w = false, bool h = false}) {
    try {
      double sw = (size / widthEmulator) * width;
      double sh = (size / heigthEmulator) * heigth;
      if (w) {
        size = sw;
      } else if (h) {
        size = sh;
      } else {
        size = min(sw, sh);
      }
    } catch (error) {
      String erro = "";
      if (size == null) {
        erro = "${erro}size == null";
      }
      if (erro.length == 0) {
        erro = error;
      }
      throw (erro);
    }
    return size;
  }

  navigator(
      {Duration duration,
      @required BuildContext context,
      NavFrom navFrom = NavFrom.rigth,
      NavFrom secondNavFrom,
      NavType navType = NavType.push,
      Widget page,
      Curve curves = Curves.linear}) {
    _customNavigator(
      context,
      duration: duration,
      navFrom: navFrom,
      secondNavFrom: secondNavFrom,
      navType: navType,
      page: page,
      curve: curves,
    );
  }

  _RoutedPage route(
      {Duration duration,
      @required BuildContext context,
      NavFrom navFrom = NavFrom.rigth,
      NavFrom secondNavFrom,
      NavType navType = NavType.push,
      @required Widget page,
      Curve curves = Curves.linear}) {
    return _animatedRoute(
      context,
      duration: duration,
      navFrom: navFrom,
      secondNavFrom: secondNavFrom,
      page: page,
      curve: curves,
    );
  }
}
