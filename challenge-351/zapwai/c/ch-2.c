#include <stdio.h>
#include <stdbool.h>

void proc(int *num, int size){
  printf("Input: ");
  for (int i = 0; i < size; i++)
    printf("%d ", num[i]);
  printf("\n");
  // sort
  int unsorted = 1;
  while (unsorted != 0) {
    unsorted = 0;
    for (int i = 0; i < size-1; i++) {
      if (num[i] > num[i+1]) {
	unsorted++;
	int tmp = num[i];
	num[i] = num[i+1];
	num[i+1] = tmp;
      }
    }
  }
  // linear?
  bool flag = false;
  int diff = num[1] - num[0];
  for (int i = 1; i < size - 1; i++) {
    if (diff != num[i+1] - num[i])
      flag = true;
  }
  printf("Output: %s\n", flag ? "false" : "true");
}

int main(){
  int num[] = {1,3,5,7,9};
  proc(num, 5);
  int num2[] = {9,1,7,5,3};
  proc(num2, 5);
  int num3[] = {1,2,4,8,16};
  proc(num3, 5);
  int num4[] = {5,-1,3,1,-3};
  proc(num4, 5);
}
