String task1(a, b, n) {
  while (b.length < n) {
    var t = a + b;
    a = b;
    b = t;
  }
  return b.substring(n - 1, n);
}

void main(List<String> args) {
  var a = args.isNotEmpty ? args : ["1234", "5678"];

  print(task1(a[0], a[1], 51));
}
