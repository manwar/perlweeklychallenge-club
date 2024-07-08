#include <stdio.h>
#include <math.h>
#include <stdlib.h>

int min(int a, int b) {
  return (a < b) ? a : b;
}

void proc(int ints[], int intslen) {
  printf("Input: { ");
  for (int i = 0; i < intslen; i++)
    printf("%d ", ints[i]);
  printf("}\n");
  int cnt = 0;
  for (int i = 0; i < intslen - 1; i++) {
    for (int j = i + 1; j < intslen; j++) {
      if (ints[i] != ints[j] && (abs(ints[i] - ints[j]) < min(ints[i],ints[j])))
	cnt++;
    }
  }
  printf("Output: %d\n", cnt);
}

int main() {
  int ints[] = {1, 2, 3, 4, 5};
  proc(ints, sizeof(ints) / sizeof(int));
  int ints2[] = {5, 7, 1, 7};
  proc(ints2, sizeof(ints2) / sizeof(int));
}

