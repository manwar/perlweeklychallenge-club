import 'dart:math';

bool isSquareFree(int n) {
  int root = sqrt(n).toInt();
  for (int i = 2; i <= root; i++) {
    if (n % i == 0) {
      n ~/= i;
      if (n % i == 0) {
        return false;
      }
      root = sqrt(n).toInt();
    }
  }
  return true;
}

void main() {
  var sFree = [
    for (int i = 1; i <= 500; i++)
      if (isSquareFree(i)) i
  ];
  print(sFree.join(', '));
}
