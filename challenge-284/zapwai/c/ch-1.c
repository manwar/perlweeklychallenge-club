#include <stdio.h>

void proc(int ints[], int intslen) {
  printf("Input: ints = { ");
  int lucky = -1;
  int max = 0;
  for (int i = 0; i < intslen; i++) {
    printf("%d ", ints[i]);
    if (max < ints[i])
      max = ints[i];
  }
  printf("}\n");
  int freq[1 + max];
  for (int i = 0; i < 1 + max; i++)
    freq[i] = 0;
  for (int i = 0; i < intslen; i++)
    freq[ints[i]]++;
  for (int i = 1; i < 1 + max; i++)
    if (i == freq[i])
      lucky = i;
  printf("Output: %d\n", lucky);
}

int main() {
  int ints[] = {2, 2, 3, 4};
  proc(ints, sizeof(ints) / sizeof(int));
  int ints2[] = {1, 2, 2, 3, 3, 3};
  proc(ints2, sizeof(ints2) / sizeof(int));
  int ints3[] = {1, 1, 1, 3};
  proc(ints3, sizeof(ints3) / sizeof(int));
}
