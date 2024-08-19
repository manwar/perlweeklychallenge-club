#include <stdio.h>

void proc(int ints[], int intslen) {
  printf("Input: ints = { ");
  for (int i = 0; i < intslen; i++)
    printf("%d ", ints[i]);
  printf("}\n");
  char* veracity = "true";
  for (int i = 0; i < intslen; i++) {
    int freq = ints[i];
    int cnt = 0;
    for (int j = 0; j < intslen; j++) {
      int elem = ints[j];
      if (elem == i)
	cnt++;
    }
    if (cnt != freq) {
      veracity = "false";
      break;
    }
  }
  printf( "Output: %s\n", veracity);
}

int main(){
  int ints[] = {1, 2, 1, 0};
  proc(ints, sizeof(ints) / sizeof(int));
  int ints2[] = {0, 3, 0};
  proc(ints2, sizeof(ints2) / sizeof(int));
}
