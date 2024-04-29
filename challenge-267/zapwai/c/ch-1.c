#include <stdio.h>

int sign_of_prod(int ints[], int intlen) {
  int num_of_negs = 0;
  for (int i = 0; i < intlen; i++) {
    if (ints[i] < 0) {
      num_of_negs++;
    } else if (ints[i] == 0) {
      return 0;
    }
  }
  return (num_of_negs % 2 == 0) ? 1 : -1;
}

void proc(int ints[], int intlen) {
  printf("Input: ints = { ");
  for (int i = 0; i < intlen; i++) 
    printf("%d ", ints[i]);
  printf("}\n");
  printf("Output: %d\n", sign_of_prod(ints, intlen));
}

int main() {
  int ints[] = {-1, -2, -3, -4, 3, 2, 1};
  proc(ints, sizeof(ints) / sizeof(int));
  int ints2[] = {1, 2, 0, -2, -1};
  proc(ints2, sizeof(ints2) / sizeof(int));
  int ints3[] = {-1, -1, 1, -1, 2};
  proc(ints3, sizeof(ints3) / sizeof(int));
}
