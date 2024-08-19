#include <stdio.h>

void proc(int ints[], int intslen) {
  printf( "Input: ints = { ");
  for (int i = 0; i < intslen; i++)
    printf("%d ", ints[i]);
  printf("}\n");
  int num = 0;
  for (int i = 0; i < intslen; i++) {
    int found = 0;
    int elem = ints[i];
    for (int j = 0; j < intslen; j++) {
      if (i == j)
	continue;
      int new_elem = ints[j];
      if (elem == new_elem)
	found = 1;
    }
    if (found == 0) {
      num = elem;
      break;
    }
  }
  printf( "Output: %d\n", num);
}

int main() {
  int ints[] = {3, 3, 1};
  proc(ints, sizeof(ints) / sizeof(int));
  int ints2[] = {3, 2, 4, 2, 4};
  proc(ints2, sizeof(ints2) / sizeof(int));
  int ints3[] = {1};
  proc(ints3, sizeof(ints3) / sizeof(int));
}
