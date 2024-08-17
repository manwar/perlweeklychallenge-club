#include <stdio.h>

int delta(int t, int* r, int rlen) {
  for (int i = 0; i < rlen; i++) {
    if (r[i] < t)
      continue;
    return r[i] - t;
  }
  return 0;
}

int main() {
  int r1[] = {11, 23, 35, 47, 59};
  int r2[] = {5, 20, 35, 50, 65};
  int length_one = 41;
  int length_two = 35;
  int outlen = 0;
  int out[60] = {};
  for (int t = 1; t < 59; t++) {
    int delta_one = delta(t, r1, sizeof(r1) / sizeof(int));
    int delta_two = delta(t, r2, sizeof(r2) / sizeof(int));
    int time_taken_one = length_one + delta_one;
    int time_taken_two = length_two + delta_two;
    if ((delta_one < delta_two) && (time_taken_one > time_taken_two)) {
      out[outlen] = t;
      outlen++;
    }
  }
  for (int i = 0; i < outlen; i++)
    printf("%d ", out[i]);
  printf("\n");
}
