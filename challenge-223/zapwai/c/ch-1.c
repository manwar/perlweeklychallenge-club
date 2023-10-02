#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int is_prime(int num) {
  for (int d = 2; d <= ceil(sqrt(num)); d++) {
    if (num % d == 0){	return 0; }
  }
  return 1;
}
int list(int n, int *L) {
  int j = 0;
  if (n >= 2) {
    L[0] = 2;
    j++;
  }
  for (int i = 2; i <= n; i++) {
    if ( is_prime(i) == 1) {
      L[j] = i;
      j++;
    }
  }
  return j;
}
int main(int argc, char *argv[]) {
  if (argc != 2) {
    printf("Please provide one value for n.\n");
    return 1;
  }
  int n = atoi(argv[1]);
  printf("Input: n = %d\n",n);
  printf("Output: ");
  int L[n];
  memset(L, 0, sizeof(L));
  int cnt = list(n, &L);
  printf("%d\n", cnt);
  if (L[0] != 0) { printf("\t(%d", L[0]); }
  for (int i = 1; i < n; i++) {
    if (L[i] != 0) { printf(", %d", L[i]); }
  }
  printf(")\n");
}
