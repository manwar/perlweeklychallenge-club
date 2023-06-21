#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <getopt.h>
int smallest(int nonzero, int *ints) {
  int min = 10000;
  int ans;
  for (int i = 0; i < nonzero; i++) {
    if (ints[i] < min) {
      min = ints[i];
      ans = i;
    }
  }
  return ans;  
}
int biggest(int nonzero, int *ints) {
  int max = -10000;
  int ans;
  for (int i = 0; i < nonzero; i++) {
    if (ints[i] > max) {
      max = ints[i];
      ans = i;
    }
  }
  return ans;
}
void shifty(int length, int *ints) {	/* Shifts nonzero elements to the left */
  int storage[length];
  for (int i = 0; i < length; i++) {
    storage[i] = ints[i];
  }
  int j = 0;
  for (int i = 0; i < length; i++) {
    ints[i] = 0;
    if (storage[i] != 0) {
      ints[j] = storage[i];
      j++;
    }
  }
}
int get_index(int opt, int length, int nonzero, int *ints) { 
  switch(opt) {
  case 's':	
    return smallest(nonzero, ints);
  case 'r':
    return rand() % (nonzero);
  case 'b':	
    return biggest(nonzero, ints);
  case 'p':	
    return nonzero - 1;
  default:
  case 'i':
    return 0;
  }
}

int main(int argc, char *argv[]) {
  int opt;
  if ((opt = getopt(argc, argv, "sbrip")) != -1)
    {
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
	else if ( (num_zero == length - 2) && (ints[0] == ints[1]) ) {
	  ints[0] = ints[1] = 0;
	  break;
	}
	
	int num1 = 0;
	num1 = get_index(opt, length, length-num_zero,ints);
	int x = ints[num1];
	ints[num1] = 0;
	shifty(length, ints);

	int num2 = get_index(opt, length, length-num_zero-1,ints);	
	int y = ints[num2];
	ints[num2] = 0;

	ints[length-1] = y - x;

	int mwidth = 0;		/* remove a few spaces for formatting */
	if (x<0){mwidth++;}; if (y<0){mwidth++;};if (y-x<0){mwidth++;};
	if (abs(x)>9){mwidth++;}; if (abs(y)>9){mwidth++;};if (abs(y-x)>9){mwidth++;};
	printf("\n\t");
	for (int i = 0; i < 6 - mwidth; i++) {
	  printf(" ");
	}
	printf("(%d, %d) --> %d :: ", x, y, y - x);
	shifty(length, ints);
	for (int i = 0; i < length - num_zero - 1; i++) {    
	  printf("%d ",ints[i]);
	}
      }
      printf("\nOutput: %d\n", ints[0]);
    }
  else {
    printf("Perl Weekly Challenge 222.\nPlease enter selection method.\n\t-b: Choose Biggest\n\t-s: Choose Smallest\n\t-r: Choose Random\n\t-i: Choose Initial Entries (shift)\n\t-p: Choose Final Entries (pop)\n");
  }
}
