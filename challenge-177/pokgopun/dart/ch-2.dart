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
      if (isValid(makeDigits(i))) {
        output += ", ${i.toString()}";
        if (--count == 0) {
          break;
        }
      }
    }
  }
  print(output.substring(2));
}

bool isValid(List<int> digits) {
  final l = digits.length;
  final m = l ~/ 2;
  if (digits[m] != 0) {
    return false;
  }
  for (var i = 0; i < m; i++) {
    if (digits[i] == 0 || digits[i] != digits[l - 1 - i]) {
      return false;
    }
  }
  return true;
}

List<int> makeDigits(int n) {
  final digits = <int>[];
  while (n > 0) {
    digits.add(n % 10);
    n ~/= 10;
  }
  return digits;
}
