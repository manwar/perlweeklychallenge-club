#include <stdio.h>
#include <stdbool.h>

int double_me (int* ints, int ints_len, int start) {
  bool flag = true;
  while (flag) {
    flag = false;
    for (int i = 0; i < ints_len; i++) {
      if (ints[i] == start) {
	flag = true;
	start *= 2;
      }
    }
  }
  return start;
}

int main() {
  int ints[] = {5, 3, 6, 1, 12};
  int start = 3;
  printf("Input: ints = { ");
  int ints_len = sizeof(ints) / sizeof(int);
  for (int i = 0; i < ints_len; i++)
    printf("%d ", ints[i]);
  printf("}, start = %d\nOutput: %d\n", start, double_me(ints, ints_len, start));
}
