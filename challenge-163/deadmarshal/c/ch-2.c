#include<stdio.h>

int summations(int *arr, size_t sz)
{
  for(size_t i = 0; i < sz; ++i)
    for(size_t j = i+1; j < sz; ++j)
      arr[j+1] = arr[j] + arr[j+1];
  return arr[sz-1];
}

int main(void)
{
  int arr[] = {1,2,3,4,5};
  int arr2[] = {1,3,5,7,9};
  size_t sz = 5;
  printf("%d\n", summations(arr, sz));
  printf("%d\n", summations(arr2, sz)); 
  return 0;
}
