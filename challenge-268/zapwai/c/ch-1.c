#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

bool check(int x[], int y[], int xlen) {
  int cnt = 0;
  for (int i = 0; i < xlen; i++)
    if (x[i] == y[i])
      cnt++;
  return ( cnt == xlen );
}

void sort(int x[], int xlen) {
  int cnt = 0;
  do {
    cnt = 0;
    for (int i = 0; i < xlen - 1; i++) {
      if (x[i] > x[i+1]) {
	cnt++;
	int tmp = x[i];
	x[i] = x[i+1];
	x[i+1] = tmp;
      }
    }
  } while (cnt != 0);
}

void proc(int x[], int y[], int xlen) {
  printf("Input:  x = ");
  for (int i = 0; i < xlen; i++)
    printf("%d ", x[i]);
  printf("\n\ty = ");
  for (int i = 0; i < xlen; i++)
    printf("%d ", y[i]);
  printf("\nOutput: ");
  sort(x, xlen);
  sort(y, xlen);
  for (int i = -99; i < 99; i++) {
    int* n = malloc(xlen * sizeof(int));
    for (int j = 0; j < xlen; j++)
      n[j] += x[j] + i;
    if (check(n, y, xlen))
      printf("%d\n", i);
    free(n);
  }
}

int main() {
  int x[] = {3, 7, 5};
  int y[] = {9, 5, 7};
  int xlen = sizeof(x) / sizeof(int);
  proc(x, y, xlen);
}
