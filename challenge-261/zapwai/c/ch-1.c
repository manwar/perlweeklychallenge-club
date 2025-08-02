#include <stdio.h>
#include <stdlib.h>

int digits_sum(int* ints, int ints_len) {
  int sum = 0;
  for (int i = 0; i < ints_len; i++) {
    do {
      sum += ints[i] % 10;
      ints[i] /= 10;
    } while (ints[i] != 0);
  }
  return sum;
}

int sum(int* ints, int ints_len) {
  int sum = 0;
  for (int i = 0; i < ints_len; i++)
    sum += ints[i];
  return sum;
}

int main() {
  int ints[] = {1,2,3,45};
  int ints_len = sizeof(ints) / sizeof(int);
  printf("Input: ints = { ");
  for (int i = 0; i < ints_len; i++)
    printf("%d ", ints[i]);
  printf("}\nOutput: %d\n", abs(sum(ints, ints_len) - digits_sum(ints, ints_len)));
}
