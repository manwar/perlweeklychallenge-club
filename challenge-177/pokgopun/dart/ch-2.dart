import "dart:math";

void main() {
  int count = 20;
  int n = 2000000;
  var pp = [false, false, for (int i = 2; i <= n; i++) true];
  //print(pp);
  for (int i = 2; i <= sqrt(n).toInt(); i++) {
    if (pp[i]) {
      var j = i * i;
      while (j <= n) {
        pp[j] = false;
        j += i;
      }
    }
  }
  int start = 100;
  int lim = start * 10;
  var output = "";
  for (int i = start; i < pp.length; i++) {
    if (i >= lim) {
      start *= 100;
      i = start;
      lim = start * 10;
    }
    if (pp[i]) {
      var p = i.toString();
      var digits = p.split("");
      int z = 0;
      for (int j = 0; j < digits.length; j++) {
        if (digits[j] == "0") {
          z++;
          if (z > 1) {
            break;
          }
        }
      }
      if (z == 1 &&
          digits[digits.length ~/ 2] == "0" &&
          p == digits.reversed.join("")) {
        output += ", $p";
        count--;
        if (count == 0) {
          break;
        }
      }
    }
  }
  print(output.substring(2));
}
