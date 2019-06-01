part of simple_code;

/// `Types Accepted:`
/// 0xffffffff
/// "ffffff"
/// "#ffffff"
/// "rgb(255, 255, 255)"
/// "rgb(255, 255, 255,1.0)"

_allColors(var cor) {
  var res;
  Color color = Color(0xffffff);
  try {
    if (cor is String) {
      if (cor.contains("rgb") || cor.contains(",")) {
        double opacity = 1.0;
        int virg = 0;
        for (int i = 0; i < cor.length; i++) {
          if (cor[i] == ",") {
            virg++;
          }
        }
        var auxCor = cor;
        auxCor = auxCor
            .replaceRange(
                0, auxCor.indexOf("(") == -1 ? 0 : auxCor.indexOf("(") + 1, "")
            .replaceAll(" ", "")
            .replaceAll(")", "");

        int r = int.parse(
            auxCor.replaceRange(auxCor.indexOf(","), auxCor.length, ""));
        auxCor = auxCor.replaceRange(0, auxCor.indexOf(",") + 1, "");
        int g = int.parse(
            auxCor.replaceRange(auxCor.indexOf(","), auxCor.length, ""));
        auxCor = auxCor.replaceRange(0, auxCor.indexOf(",") + 1, "");
        int b;
        if (virg == 2) {
          opacity = 1.0;
          b = int.parse(auxCor);
        } else if (virg == 3) {
          b = int.parse(
              auxCor.replaceRange(auxCor.indexOf(","), auxCor.length, ""));
          auxCor = auxCor.replaceRange(0, auxCor.indexOf(",") + 1, "");
          opacity = double.parse(auxCor);
        }
        color = Color.fromRGBO(r, g, b, opacity);
        return color;
      }
      res = cor.replaceFirst("#", "").replaceFirst("0xff", "");
    } else if (cor is int) {
      res = cor.toString().replaceAll("0xff", "");
    }
    color = Color(int.parse("0xff$res"));
  } catch (e) {
    throw ("$cor color does not exist");
  }
  return color;
}
