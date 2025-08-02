#include <stdio.h>
#include <stdlib.h>

int main() {
  int ints[] = {-3, 1, 2, -1, 3, -2, 4};
  printf("Input: ints = { ");
  for (int i = 0; i < sizeof(ints)/sizeof(int); i++)
    printf("%d ", ints[i]);
  printf("}\n");
  int neg = 0;
  int pos = 0;
  for (int i = 0; i < sizeof(ints)/sizeof(int); i++) {
    if (ints[i] < 0) {
      if (neg > ints[i]) 
	neg = ints[i]; 
    } else {
      if (pos < ints[i])
	pos = ints[i];
    }
  }
  int ans = (abs(neg) > pos) ? abs(neg) : pos;
  printf( "Output: %d\n", ans);
}
