#include<stdio.h>

size_t count_equal_divisible(int *arr, size_t sz, int k)
{
  size_t count = 0;
  for(size_t i = 0; i < sz-1; ++i){
    for(size_t j = i+1; j < sz; ++j){
      if((arr[i] == arr[j]) && ((i*j) % k == 0)) count++;
    }
  }
  return count;
}

int main(void)
{
  int arr1[] = {3,1,2,2,2,1,3};
  int arr2[] = {1,2,3};
  size_t sz1 = 7,sz2 = 3;
  printf("%zu\n",count_equal_divisible(arr1,sz1,2));
  printf("%zu\n",count_equal_divisible(arr2,sz2,1));
  return 0;
}

