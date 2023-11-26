#include<stdio.h>

size_t floor_sum(int *arr,size_t sz)
{
  size_t sum = 0;
  for(size_t i = 0; i < sz; ++i)
    for(size_t j = 0; j < sz; ++j)
      sum += (size_t)(arr[i] / arr[j]);
  return sum;
}

int main(void)
{
  int arr1[] = {2,5,9};
  int arr2[] = {7,7,7,7,7,7,7};
  size_t sz = 3, sz2 = 7;
  printf("%zu\n",floor_sum(arr1,sz));
  printf("%zu\n",floor_sum(arr2,sz2));
  return 0;
}

