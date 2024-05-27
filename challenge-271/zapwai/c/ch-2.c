#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#define POW2 10			/* biggest power of 2 in entries */

int* dec_to_bin(int x, int N) {
  int* b = malloc(sizeof(int) * (N+1));
  for (int i = 0; i <= N; i++) {
    if (x >= pow(2, N - i)) {
      b[i] = 1;
      x -= pow(2, N - i);
    } else {
      b[i] = 0;
    }
  }
  return b;
}

void proc(int N, int ints[N]) {
  printf("Input: { ");
  for (int i = 0; i < N; i++)
    printf("%d ", ints[i]);
  printf("}\n");
  int count[N];
  for (int i = 0; i < N; i++)
    count[i] = 0;
  for (int k = 0; k < N; k++) {
    int i = ints[k]; 
    int* bin = dec_to_bin(i, POW2);
    for (int j = 0; j <= POW2; j++) {
      if (bin[j] == 1)
	count[k]++;
    }
    free(bin);
  }
  int ord[N];
  for (int i = 0; i < N; i++)
    ord[i] = ints[i];
  int c = 1;
  while (c != 0) {
    c = 0;
    for (int i = 0; i < N-1; i++) {
      if (count[i] > count[i+1]) {
	c++;
	int tmp_cnt = count[i];
	int tmp_int = ord[i];
	count[i] = count[i+1];
	count[i+1] = tmp_cnt;
	ord[i] = ord[i+1];
	ord[i+1] = tmp_int;
      }
    }
  }
  c = 1;
  while (c != 0) {
    c = 0;
    for (int i = 0; i < N-1; i++) {
      if (count[i] != count[i+1])
	continue;
      if (ord[i] > ord[i+1]) {
	c++;
	int tmp_int = ord[i];
	ord[i] = ord[i+1];
	ord[i+1] = tmp_int;
	int tmp_cnt = count[i];
	count[i] = count[i+1];
	count[i+1] = tmp_cnt;
      }
    }
  }
  printf("Output: { ");
  for (int i = 0; i < N; i++)
    printf("%d ", ord[i]);
  printf("}\n");
}

int main() {
  int ints[] = {0, 1, 2, 3, 4, 5, 6, 7, 8};
  proc(sizeof(ints)/sizeof(int), ints);
  int ints2[] = {1024, 512, 256, 128, 64};
  proc(sizeof(ints2)/sizeof(int), ints2);
}
