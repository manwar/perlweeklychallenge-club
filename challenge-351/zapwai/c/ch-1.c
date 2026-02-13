#include <stdio.h>

int max(int* nums, int size) {
  int max = nums[0];
  for (int i = 0; i < size; i++) {
    if (max < nums[i])
      max = nums[i];
  }
  return max;
}

int min(int* nums, int size) {
  int min = nums[0];
  for (int i = 0; i < size; i++) {
    if (min > nums[i])
      min = nums[i];
  }
  return min;
}

float spec_avg(int* nums, int size) {
  int sum = 0;
  for (int i = 0; i < size; i++)
    sum += nums[i];
  int max_val = max(nums, size);
  int min_val = min(nums, size);
  int max_cnt = 0;
  int min_cnt = 0;
  for (int i = 0; i < size; i++) {
    if (nums[i] == min_val) {
      min_cnt++;
    } else if (nums[i] == max_val) {
      max_cnt++;
    }
  }
  sum = sum - min_cnt*min_val - max_cnt*max_val;
  return (max_val == min_val) ? 0 : sum/(size - min_cnt - max_cnt);
}

void proc(int* ints, int size) {
  printf("Input: ");
  for (int i = 0; i < size; i++)
    printf("%d ", ints[i]);
  printf("\n");
  printf("Output: %f\n", spec_avg(ints,size));
}

int main() {
  int ints[] = {8000, 5000, 6000, 2000, 3000, 7000};
  proc(ints, 6);

  int ints2[] = {100000, 80000, 110000, 90000};
  proc(ints2, 4);

  int ints3[] = {2500, 2500, 2500, 2500};
  proc(ints3, 4);

  int ints4[] = {2000};
  proc(ints4, 1);

  int ints5[] = {1000, 2000, 3000, 4000, 5000, 6000};
  proc(ints5, 6);
}
