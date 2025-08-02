#include<stdio.h>

size_t complete_day(int *arr,size_t sz)
{
  size_t count = 0;
  for(size_t i = 0; i < sz-1; ++i)
    for(size_t j = i+1; j < sz; ++j)
      if((arr[i] + arr[j]) % 24 == 0) count++;
  return count;
}

int main(void)
{
  int arr1[] = {12,12,30,24,24};
  int arr2[] = {72,48,24,55};  
  int arr3[] = {12,18,24};
  size_t sz1 = 5,sz2 = 4,sz3 = 3;
  printf("%zu\n",complete_day(arr1,sz1));
  printf("%zu\n",complete_day(arr2,sz2));
  printf("%zu\n",complete_day(arr3,sz3));
  return 0;
}
  