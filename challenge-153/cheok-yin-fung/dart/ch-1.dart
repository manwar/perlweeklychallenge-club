// The Weekly Challenge 153
// Task 1: Left Factorials
// Usage: $ dart ch-1.dart

void main() {
  const arg = 10;
  var factorial = [1];
  for (int i = 1; i <= arg; i++) {
    factorial.add(factorial[i-1]*i);
  }

  var leftfactorial = [0];

  for (int i = 1; i <= arg; i++) {
    leftfactorial.add(leftfactorial[i-1]+factorial[i-1]);
  }
  for (int i = 1; i <= arg; i++) {
    print(leftfactorial[i]);
  }
}
