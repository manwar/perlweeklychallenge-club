#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
int main() {
  char x[] = "003407";
  int xlen = sizeof(x) / sizeof(char);
  char* y = malloc( sizeof(x) );
  *y = '\0';
  bool off = true;
  int j = 0;
  for (int i = 0; i < xlen; i++) {
    if (off) {
      if (x[i] != '0') {
	off = false;
	y[j] = x[i];
	j++;
      } 
    } else {
      y[j] = x[i];
      j++;
    }
  }
  printf("Input: %s\n", x);
  printf("Output: %s\n", y);
  free(y);
}
