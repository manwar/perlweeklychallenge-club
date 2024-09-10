#include <stdio.h>
#define MAXLEN 64
int min(int a, int b) {return (a < b) ? a : b;}
int max(int a, int b) {return (a < b) ? b : a;}
void proc(int ints[], int intslen) {
  printf("Input: ints = { ");
  for (int i = 0; i < intslen; i++)
    printf("%d ", ints[i]);
  printf("}\n");
  while (intslen > 2) {
    int L[MAXLEN] = {};
    int j = 0;
    for (int i = 0; i < intslen/2; i++) {
      if (i % 2 == 0) {
	L[j] = min(ints[2*i], ints[2*i + 1]);
      } else {
	L[j] = max(ints[2*i], ints[2*i + 1]);
      }
      j++;
    }
    for (int i = 0; i < intslen/2; i++) {
      ints[i] = L[i];
    }
    intslen /= 2;
  }
  printf("Output: %d\n", min(ints[0], ints[1]));
}

int main() {
  int ints[] = {2, 1, 4, 5, 6, 3, 0, 2};
  proc(ints, sizeof(ints)/sizeof(int));
  int ints2[] = {0, 5, 3, 2};
  proc(ints2, sizeof(ints2)/sizeof(int));
  int ints3[] = {9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8};
  proc(ints3, sizeof(ints3)/sizeof(int));
}


