void main() {
  int count = 19;
  int n;
  for (int i = 0; i < 5000000; i++) {
    n = i;
    List<int> digits = [];
    while (n > 0) {
      digits.add(n % 10);
      n ~/= 10;
    }
    //print(i);
    int sum = 0;
    int m = 0;
    for (int j in digits.reversed) {
      n = j;
      for (int k = 0; k < m; k++) {
        n *= j;
      }
      m++;
      sum += n;
    }
    if (sum == i) {
      print(i);
      count--;
      if (count == 0) {
        break;
      }
    }
  }
}
