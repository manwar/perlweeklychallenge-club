void main() {
  for (int i = 1; i >= -1; i -= 2) {
    for (int j = 1; j <= 16; j++) {
      final n = i * j;
      final qi = toQI(n, <int>[]);
      print('toQI($n) = $qi, fromQI($qi) = ${fromQI(qi).toString()}');
    }
  }
  //print(toQI(4, <int>[]));
}

int fromQI(String qi) {
  var b = [
    ...[...qi.split('').map((s) => int.parse(s))].reversed
  ];
  int sum = 0;
  int ii = 1;
  for (int i = 0; i < b.length; i += 2) {
    sum += b[i] * ii;
    ii *= -4;
  }
  return sum;
}

String toQI(int n, List<int> res) {
  if (n > 0) {
    res.addAll([n % 4, 0]);
    toQI(-1 * (n ~/ 4), res);
  } else if (n < 0) {
    int i = 1;
    while (-4 * i > n) {
      i++;
    }
    res.addAll([4 * i + n, 0]);
    toQI(i, res);
  }
  if (res.isEmpty) {
    return "0";
  }
  return res.reversed.join('').substring(1);
}
