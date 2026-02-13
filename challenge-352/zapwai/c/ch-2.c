#include <stdio.h>
#include <math.h>
#include <stdbool.h>

void proc(int *nums, int size) {
  printf("Input: ");
  for (int i = 0; i < size; i++)
    printf("%d ", nums[i]);
  printf("\n");

  bool out[size] = {};
  for (int i = 0; i < size; i++) {
    int sum = 0;
    for (int j = 0; j <= i; j++) {
      printf("%d", nums[j]);
    }
    printf(" -> ");
    for (int j = 0; j <= i; j++)
      sum += pow(2,j) * nums[i - j];
    printf("%d\n", sum);
    if (sum % 5 == 0)
      out[i] = true;
    else
      out[i] = false;
  }
  printf("Output: ");
  for (int i = 0; i < size; i++)
    printf("%s ", out[i] ? "true" : "false");
  printf("\n");
}

int main() {
  int nums[] = {1,0,1};
  int size = sizeof(nums) / sizeof(int);
  proc(nums, size);

  int nums2[] = {1,1,1,1,1};
  size = 5;
  proc(nums2, size);

  int nums3[] = {1,0,1,1,0,1,0,0,1,1};
  size = sizeof(nums3) / sizeof(int);
  proc(nums3, size);
} 
