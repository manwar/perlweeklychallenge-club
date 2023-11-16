#include<stdio.h>

size_t reverse_pairs(int *arr,size_t sz)
{
  size_t count = 0;
  for(size_t i = 0; i < sz-1; ++i)
    for(size_t j = i+1; j < sz; ++j)
      if(arr[i] > (2 * arr[j])) count++;
  return count;
}

int main()
{
  int arr1[] = {1,3,2,3,1};
  int arr2[] = {2,4,3,5,1};
  size_t sz1 = 5,sz2 = 5;
  printf("%zu\n",reverse_pairs(arr1,sz1));
  printf("%zu\n",reverse_pairs(arr2,sz2));
  return 0;
}

