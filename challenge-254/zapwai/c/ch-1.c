#include <stdio.h>

void proc(int n) {
  printf("Input: %d\n",n);
  printf("Output: ");
  int r = n % 3;
  if (n == 1) {
    printf("True\n");
    return;
  } 
  else if (n < 3) {
    printf("False\n");
    return;
  }
  else {
    while (n > 1) {
      r = n % 3;
      n = n / 3;
    }
    if (r != 0) {
      printf("False\n");
      return;
    }
    if ( (n == 1) && (r == 0) ) {
      printf("True\n");
      return;
    }    
  }
}

int main() {
  int l[] = {27, 0, 6};
  for (int i = 0; i < sizeof(l)/sizeof(int); i++) {
    proc(l[i]);
  }
}