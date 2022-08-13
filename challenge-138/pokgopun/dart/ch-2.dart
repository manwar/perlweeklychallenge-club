import "dart:math";

void main(List<String> args) {
  int n = args.isNotEmpty && int.tryParse(args[0]) != null
      ? int.parse(args[0])
      : 9801;
  print('Input: n = $n\nOutput: ${isSplitNum(n)}');
}

List<String> numSplit(String s, String t, List<String> res) {
  var l = s.length;
  if (l > 0) {
    for (int i = 0; i < l; i++) {
      numSplit(s.substring(i + 1), <String>[t, s.substring(0, i + 1)].join("+"),
          res);
    }
  } else {
    res.add(t.substring(1));
    return <String>[];
  }
  return res;
}

bool isSplitNum(int n) {
  int nSqrt = sqrt(n).toInt();
  if (n != nSqrt * nSqrt) {
    return false;
  }
  for (var splits in numSplit(n.toString(), "", <String>[])) {
    if (splits
            .split("+")
            .map((str) => int.parse(str))
            .fold<int>(0, (prev, elem) => prev + elem) ==
        nSqrt) {
      //print('Since sqrt($n) = $nSqrt = $splits');
      return true;
    }
  }
  return false;
}
