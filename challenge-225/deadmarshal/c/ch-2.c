#include<stdio.h>
#include<stdlib.h>

void left_right_sum_diff(int *arr, size_t sz)
{
  size_t left = 0,right = 0;
  for(size_t i = 1; i < sz; ++i) right += arr[i];
  for(size_t i = 0; i < sz; ++i)
  {
    printf("%d ", abs(left - right));
    left += arr[i];
    right -= i < sz-1 ? arr[i+1] : 0;
  }
  puts("");
}

int main()
{
  int a1[] = {10,4,8,3};
  int a2[] = {1};
  int a3[] = {1,2,3,4,5};
  size_t sz1 = 4, sz2 = 1, sz3 = 5;
  left_right_sum_diff(a1,sz1);
  left_right_sum_diff(a2,sz2);
  left_right_sum_diff(a3,sz3);
  return 0;
}

