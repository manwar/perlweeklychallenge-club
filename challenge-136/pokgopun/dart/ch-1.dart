void main(List<String> args) {
  List<List<int>> samples = [];
  if (args.length > 1 &&
      int.tryParse(args[0]) != null &&
      int.tryParse(args[1]) != null) {
    samples.add(args.map((arg) => int.parse(arg)).toList());
  }
  if (samples.isEmpty) {
    samples = [
      [8, 24],
      [26, 39],
      [4, 10]
    ];
  }
  //print(samples);
  for (var s in samples) {
    print(
        'Input: m = ${s[0]}, n = ${s[1]}\nOutput: ${gcdEuclidean(s[0], s[1]) % 2 == 0 ? 1 : 0}\n');
  }
}

int gcdEuclidean(int a, int b) {
  while (a != b) {
    if (a > b) {
      a -= b;
    } else {
      b -= a;
    }
  }
  return a;
}
