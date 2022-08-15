void main(List<String> args) {
  //final samples = <int>[16, 9, 15];
  final List<int> samples = [...args.map((arg) => int.parse(arg))];
  if (args.isEmpty || samples.length != args.length) {
    samples
      ..clear()
      ..addAll([16, 9, 15]);
  }
  for (var n in samples) {
    var s = fib(n);
    //print(s);
    final l = s.length;
    final List<List<int>> res = [];
    for (int r = 2; r <= l; r++) {
      count(n, r, s, <int>[], res);
    }
    //print('Input: n = $n\nOutput: ${res.length}\n$res\n');
    print('Input: n = $n\nOutput: ${res.length}\n');
  }
}

List<int> fib(int n) {
  final s = <int>[0, 1];
  while (s.last < n) {
    s.add(s[s.length - 1] + s[s.length - 2]);
  }
  return s.sublist(2, s.length - 1);
}

int count(int n, int r, List<int> e, List<int> c, List<List<int>> res) {
  final lc = c.length;
  final le = e.length;
  if (lc == r || lc + le == r) {
    final s = <int>[...c, for (int i = 0; i < r - lc; i++) e[i]];
    if (s.reduce((val, elem) => val + elem) == n) {
      res.add(s);
    }
    return 0;
  } else {
    for (int i = 0; i <= lc + le - r; i++) {
      count(n, r, e.sublist(i + 1), <int>[...c, e[i]], res);
    }
  }
  return res.length;
}
