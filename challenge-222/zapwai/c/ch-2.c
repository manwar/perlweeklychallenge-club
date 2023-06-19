#include <stdio.h>
#include <stdlib.h>
#include <time.h>
int main() {
  srand(time(0));  
  int ints[] = {2, 7, 4, 1, 8, 1};
  int length = sizeof(ints) / sizeof(ints[0]);
  printf(" Input: ");  
  for (int i = 0; i < length; i++) {
    printf("%d ",ints[i]);
  }
  for (int n = 0; n < length - 1; n++) {
    int num_zero = 0;
    for (int i = 0; i < length; i++) {
      if (ints[i] == 0) {	num_zero++;      }
    }
    if (num_zero == length - 1) {      break;    }
    int num1 = 0;
    while (ints[num1] == 0) {
      num1 = rand() % (length);
    }
    int x = ints[num1];
    ints[num1] = 0;
    int num2 = 0;
    while ( (num2 == num1) || (ints[num2] == 0) ){
      num2 = rand() % (length);
    }
    int y = ints[num2];
    ints[num2] = y - x;
    int mwidth = 0;		/* remove a few spaces for formatting */
    if (x<0){mwidth++;}; if (y<0){mwidth++;};if (y-x<0){mwidth++;};
    if (abs(x)>9){mwidth++;}; if (abs(y)>9){mwidth++;};if (abs(y-x)>9){mwidth++;};
    printf("\n\t");
    for (int i = 0; i < 6 - mwidth; i++) {
      printf(" ");
    }
    printf("(%d, %d) --> %d :: ", x, y, y - x);
    for (int i = 0; i < length; i++) {    
      printf("%d ",ints[i]);
    }
  }
  for (int i = 0; i < length; i++) {
    if (ints[i] != 0) {
      printf("\nOutput: %d\n", ints[i]);
    }
  }
}
