#include <stdio.h>

void proc(int ints[], int intslen) {
  printf( "Input: ints = { ");
  for (int i = 0; i < intslen; i++)
    printf("%d ", ints[i]);
  printf("}\n");
  char* ans = "false";
  for (int i = 0; i < intslen - 1; i++) {
    for (int j = i + 1; j < intslen; j++) {
	if (ints[i] == 2 * ints[j] || ints[j] == 2 * ints[i]) {
	  ans = "true";
	}
      }
  }
  printf( "Output: %s\n", ans);
}

int main() {
  int ints[] = {6, 2, 3, 3};
  proc(ints, 4);
  int ints2[] = {3, 1, 4, 13};
  proc(ints2, 4);
  int ints3[] = {2, 1, 4, 2};
  proc(ints3, 4);

}

