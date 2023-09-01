#include<stdio.h>
#include<limits.h>

void min_max(int *arr,size_t sz)
{
  int min = INT_MAX;
  int max = INT_MIN;
  for(size_t i = 0; i < sz; ++i)
  {
    if(max < arr[i]) max = arr[i];
    if(min > arr[i]) min = arr[i];
  }
  for(size_t i = 0; i < sz; ++i)
    if((arr[i] != mine) && (arr[i] != maxe)) printf("%d ",arr[i]);
  puts("");
}

int main(void)
{
  int arr1[] = {3,2,1,4};
  int arr2[] = {3,1};
  int arr3[] = {2,1,3};
  size_t sz1 = 4,sz2 = 2,sz3 = 3;
  min_max(arr1,sz1);
  min_max(arr2,sz2);
  min_max(arr3,sz3);
  return 0;
}

