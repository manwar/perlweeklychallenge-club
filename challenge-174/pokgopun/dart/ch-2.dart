void main() {
  final n = 3;
  permutation(n).asMap().forEach((key, value) {
    print("$key: $value");
  });
  print("\npermutation2rank(" +
      rank2permutation(n, 2).toString() +
      ") = " +
      permutation2rank(rank2permutation(n, 2)).toString());
  print("\nrank2permutation(" +
      rank2permutation(n, 0).toString() +
      ", 1) = " +
      rank2permutation(n, 1).toString());
}

List<List<int>> permutation(int n) {
  return [for (var r = 0; r < factorial(n); r++) rank2permutation(n, r)];
}

int permutation2rank(List<int> p) {
  final n = p.length;
  var fact = factorial(n - 1);
  var r = 0;
  final digits = [for (var i = 0; i < n; i++) i];
  int q;
  for (var i = 0; i < n - 1; i++) {
    q = digits.indexOf(p[i]);
    r += fact * q;
    digits.removeAt(q);
    fact ~/= n - 1 - i;
  }
  return r;
}

List<int> rank2permutation(int n, int r) {
  var fact = factorial(n - 1);
  if (r > fact * n - 1) {
    return [];
  }
  final digits = [for (var i = 0; i < n; i++) i];
  final p = <int>[];
  int q;
  for (var i = 0; i < n; i++) {
    q = r ~/ fact;
    r %= fact;
    p.add(digits[q]);
    digits.removeAt(q);
    if (i != n - 1) {
      fact ~/= n - 1 - i;
    }
  }
  return p;
}

int factorial(int n) {
  if (n == 0) {
    return 1;
  }
  return n * factorial(n - 1);
}
