#include <stdio.h>
void printlist(int *a, int len) {
  printf("(");
  for (int i = 0; i < len - 1; i++) {
    printf("%d, ", a[i]);    
  }
  printf("%d", a[len-1]);
  printf(")\n");
}

void proc(int *ints, int len) {
  int cnts[len];
  for (int i = 0; i < len; i++) { cnts[i] = 0; }  
  for (int i = 0; i < len; i++) {
    for (int j = 0; j < len; j++) {    
      if (ints[i] > ints[j]) {
	cnts[i]++;
      }
    }
  }
  printf("Input: ");
  printlist(ints, len);
  printf("Output: ");
  printlist(cnts, len);  
}

int main() {
  int ints[] = {5, 2, 1, 6};
  int len = sizeof(ints) / sizeof(int);
  proc(ints, len);

  int ints2[] = {2, 1, 0, 3};
  int len2 = sizeof(ints2) / sizeof(int);
  proc(ints2, len2);

  int ints3[] = {0, 1};
  int len3 = sizeof(ints3) / sizeof(int);
  proc(ints3, len3);
}
