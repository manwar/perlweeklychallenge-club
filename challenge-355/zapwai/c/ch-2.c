#include <stdio.h>
#include <string.h>
#include <stdbool.h>

bool is_mnt(int *num, int numlen) {
  int count = 0;
  for (int candidate = 1; candidate < numlen - 1; candidate++) {
    for (int i = 0; i < numlen - 1; i++) {
      if (i == candidate)
	continue;
      if (i < candidate) {
	if (num[i] > num[i+1]) {
	  count++;
	  continue;
	}
      } else {
	if (num[i] < num[i+1]) {
	  count++;
	  continue;
	}
      }
    }
  }
  return (count < numlen - 2);
}

void proc(int *num, int numlen) {
  printf("Input: ");
  for (int i = 0; i < numlen; i++)
    printf("%d ", num[i]);
  printf("\n");

  if (numlen < 3) {
    printf("Output: false\n");
  } else {
    printf("Output: %s\n", (is_mnt(num, numlen)) ? "true" : "false");
  }
}

int main() {
  int num[] = {1,2,3,4,5};
  proc(num, 5);
  int num2[] = {0,2,4,6,4,2,0};
  proc(num2, 7);
  int num3[] = {5,4,3,2,1};
  proc(num3, 5);
  int num4[] = {1,3,5,5,4,2};
  proc(num4, 6);
  int num5[] = {1,3,2};
  proc(num5, 3);
  return 0;
}
