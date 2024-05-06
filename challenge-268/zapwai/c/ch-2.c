#include <stdio.h>
#include <stdlib.h>

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

void proc(int ints[], int len) {
  printf("Input: ");
  for (int i = 0; i < len; i++)
    printf("%d ", ints[i]);
  int* new = malloc(len * sizeof(int));
  sort(ints, len);
  int j = 0;
  do {
    int x = ints[j];
    int y = ints[j+1];
    new[j] = y;
    new[j+1] = x;
    j += 2;
  } while (j < len);
  printf("\nOutput: ");
  for (int i = 0; i < len; i++)
    printf("%d ", new[i]);
  printf("\n");
  free(new);
}

int main() {
  int ints[] = {2, 5, 3, 4};
  proc(ints, sizeof(ints) / sizeof(int));
}

