#include <stdio.h>
#include <stdbool.h>

bool zags(int alen, int a[alen]) {
  if (alen == 1) return true;
  if (a[1] == a[0]) return false;
  if (a[0] > a[1])
    /* negate entries */
    for (int i = 0; i < alen; i++)
      a[i] *= -1;
  for (int i = 0; i < alen - 1; i++) {
    if (i % 2 == 0) {
      if (a[i] >= a[i+1])
	return false;
    } else {
      if (a[i] <= a[i+1])
	return false;
    }
  }
  return true;
}

void proc(int numlen, int nums[numlen]) {
  printf("Input: ");
  for (int i = 0; i < numlen; i++)
    printf("%d ", nums[i]);
  printf("\n");

  int len = numlen;
  int s = 0;			/* starting index */

  bool done = false;
  done = zags(len, nums);
  
  while (!done) {
    if (s < numlen - len) {
      s++;
      int t[len] = {};
      for (int i = 0; i < len; i++)
	t[i] = nums[s + i];
      done = zags(len, t);
    } else {
      len--;
      s = 0;
      int t[len] = {};
      for (int i = 0; i < len; i++)
	t[i] = nums[s + i];
      done = zags(len, t);
    }
  }
  printf("Output: %d\n", len);
}

int main() {
  int nums[] = {9, 4, 2, 10, 7, 8, 8, 1, 9};
  proc(sizeof(nums)/sizeof(int), nums);
  int nums2[] = {1, 7, 4, 9, 2, 5};
  proc(sizeof(nums2)/sizeof(int), nums2);
  int nums3[] = {1, 2, 3, 4, 5};
  proc(sizeof(nums3)/sizeof(int), nums3);
  int nums4[] = {4,4,4};
  proc(sizeof(nums4)/sizeof(int), nums4);
  int nums5[] = {10, 20, 15, 12, 18};
  proc(sizeof(nums5)/sizeof(int), nums5);
}
