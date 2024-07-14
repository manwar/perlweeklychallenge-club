#include <stdio.h>

int cf_func(const void* a, const void* b) {
  return *(const int*)a > *(const int*)b ? 1 : -1;
}

int strong_count( int *nums, int len ) {
  if (!len)
    return 0;

  qsort( nums, len, sizeof( int ), cf_func );

  // make unique
  int j = 0;
  for (int i=0; i < len; i++) {
    if (nums[i] != nums[j]) {
	nums[++j] = nums[i];
    }
  }
  j++;

  int count = 0;
  for (int i=0; i < j; i++) {
    for (int k=i+1; k < j && nums[k] < 2 * nums[i]; k++) {
      count++;
    }
  }

  return count;
}

int main() {
  int const num_inputs = 2;
  int inputs[num_inputs][6] = {
    {5, 1, 2, 3, 4, 5},
    {4, 5, 7, 1, 7}
  };
  for (int i=0; i < num_inputs; i++) {
    int val = strong_count(&inputs[i][1], inputs[i][0]);
    printf("input: %d result: %d\n",i, val);
  }
}
