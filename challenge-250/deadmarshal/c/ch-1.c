#include<stdio.h>

int smallest_index(int *arr,size_t sz)
{
  for(size_t i = 0; i < sz; ++i)
    if(i % 10 == arr[i]) return i;
  return -1;
}

int main(void)
{
  int arr1[] = {0,1,2};
  int arr2[] = {4,3,2,1};
  int arr3[] = {1,2,3,4,5,6,7,8,9,0};
  size_t sz1 = 3,sz2 = 4,sz3 = 10;
  printf("%d\n",smallest_index(arr1,sz1));
  printf("%d\n",smallest_index(arr2,sz2));
  printf("%d\n",smallest_index(arr3,sz3));
  return 0;
}

