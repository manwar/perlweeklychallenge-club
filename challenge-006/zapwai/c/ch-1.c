#include <stdio.h>
#include <stdbool.h>
void proc(int, int*);

int main() {
  int list[] = {1,2,3,4,9,10,14,15,16};
  int list_len = sizeof(list) / sizeof(int);
  proc(list_len, list);
}

void proc(int list_len, int* list) {
  printf("Input: list = { ");
  for (int i = 0; i < list_len; i++)
    printf("%d ", list[i]);
  printf("}\n");
  printf("Output: ");
  
  bool init_flag = false;	/* First 2 meighboring nums detected */
  bool cont_flag = false;	/* True when a 3rd neighbor is detected */

  for (int i = 0; i < -1 + list_len; i++) {
    int diff = list[i+1] - list[i];
    if (init_flag && cont_flag) {
      if (diff != 1) {
	init_flag = false;
	cont_flag = false;
	printf("-");
	printf("%d", list[i]);
      }
    } else if (init_flag) {
      if (diff == 1)
	cont_flag = true;
      else {
	init_flag = false;
	printf(",");
	printf("%d", list[i]);
      }
    } else {
      if (i != 0)
	printf(",");
      printf("%d", list[i]);
      if (diff == 1)
	init_flag = true;
    }
  }
  if (init_flag && cont_flag)
    printf("-%d", list[list_len - 1]);
  else
    printf(",%d", list[list_len - 1]);

  printf("\n");
}
