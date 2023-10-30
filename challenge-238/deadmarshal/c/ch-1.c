#include<stdio.h>

void running_sum(int *arr,size_t sz)
{
  int sum = 0;
  for(size_t i = 0; i < sz; ++i)
  {
    sum += arr[i];
    printf("%d ",sum);
  }
  puts("");
}

int main(void)
{
  int arr1[] = {1,2,3,4,5};
  int arr2[] = {1,1,1,1,1}; 
  int arr3[] = {0,-1,1,2};
  size_t sz1 = 5,sz2 = 5,sz3 = 4;
  running_sum(arr1,sz1);
  running_sum(arr2,sz2);
  running_sum(arr3,sz3);
  return 0;
}

