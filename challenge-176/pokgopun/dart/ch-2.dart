void main() {
  final rnumbers = <int>[];
  for (int i = 10; i < 100; i++) {
    //print("i = " + i.toString());
    var n = i;
    var r = 0;
    while (n > 0) {
      r *= 10;
      r += n % 10;
      n ~/= 10;
    }
    //print("i + r = " + (i + r).toString());
    n = i + r;
    var isReversible = true;
    while (n > 0) {
      if (n % 2 == 0) {
        isReversible = false;
        break;
      }
      n ~/= 10;
    }
    if (isReversible) {
      //print(i);
      rnumbers.add(i);
    }
  }
  print(rnumbers);
}
