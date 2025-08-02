#include <stdio.h>

int max(int ints[], int intslen) {
  int max = ints[0];
  for (int i = 1; i < intslen; i++)
    if (max < ints[i])
      max = ints[i];
  return max;
}

void proc(int ints[], int intslen) {
  printf( "Input: { ");
  for (int i = 0; i < intslen; i++)
    printf("%d ", ints[i]);
  printf("}\n");
  int ans = max(ints, intslen);
  int new1[intslen];
  int new1len = 0;
  for (int i = 0; i < intslen; i++)
    if (ints[i] != ans) {
      new1[new1len] = ints[i];
      new1len++;
    }
  int new2[intslen];
  int new2len = 0;
  if (new1len > 0) {
    int m2 = max(new1, new1len);
    for (int i = 0; i < new1len; i++)
      if (new1[i] != m2) {
	new2[new2len] = new1[i];
	new2len++;
      }
    if (new2len > 0)
      ans = max(new2, new2len);
  }
  printf( "Output: %d\n", ans);
}

int main() {
  int ints[] = {5, 6, 4, 1};
  proc(ints, sizeof(ints) / sizeof(int));
  int ints2[] = {4, 5};
  proc(ints2, sizeof(ints2) / sizeof(int));
  int ints3[] = {1, 2, 2, 3};
  proc(ints3, sizeof(ints3) / sizeof(int));
}
