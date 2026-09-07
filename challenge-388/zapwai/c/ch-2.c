#include <stdio.h>

int fact(int n) {
  if (n == 1) return 1;
  return n*fact(n-1);
}

int comb(int n, int r) {
  return fact(n) / (fact(n-r) * fact(r));
}

int N(int n);

int B(int n, int k) {
  return comb(n, k) * N(n-k);
}

int N(int n) {
  if (n == 1) return 0;
  int bad = 1;
  for (int i = 1; i <= n-2; i++)
    bad += B(n, i);
  return fact(n) - bad;
}

void proc(int n) {
  printf("Input: %d\n", n);
  printf("Output: %d\n", N(n));
}

void main(){
  int n = 1;
  proc(n);
  n = 2;
  proc(n);
  n = 3;
  proc(n);
  n = 4;
  proc(n);
  n = 5;
  proc(n);
}
