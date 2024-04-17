#include <stdio.h>

void proc(int ints[], int intlen) {
  printf("Input: ints = { ");
  for (int i = 0; i < intlen; i++)
    printf("%d ", ints[i]);
  printf("}\n");
  float third = intlen / 3.0;
  int freq[intlen];
  for (int i = 0; i < intlen; i++)
    freq[i] = 0;
  for (int i = 0; i < intlen; i++) 
    freq[ints[i]]++;
  int ans[3] = {};
  int j = 0;
  for (int val = 0; val < intlen; val++) {
    if (freq[val] >= third) {
      ans[j] = val;
      j++;
    }
  }
  printf("Output: %d\n", ans[0]);
}

int main() {
  int ints[] = {1,2,3,3,3,3,4,2};
  int ints2[] = {1,1};
  int ints3[] = {1,2,3};
  proc(ints, sizeof(ints) / sizeof(int));
  proc(ints2, sizeof(ints2) / sizeof(int));
  proc(ints3, sizeof(ints3) / sizeof(int));
}
