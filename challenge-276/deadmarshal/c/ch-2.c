#include<stdio.h>

size_t maximum_frequency(const int *arr,size_t sz)
{
  size_t count = 0;
  int max = arr[0];
  int hash[10] = {0};
  for(size_t i = 0; i < sz; ++i) hash[arr[i]]++;
  for(size_t i = 0; i < 10; ++i) if(hash[i] > max) max = hash[i];
  for(size_t i = 0; i < 10; ++i) if(hash[i] == max) count += hash[i];
  return count;
}

int main(void)
{
  int arr1[] = {1,2,2,4,1,5};
  int arr2[] = {1,2,3,4,5};
  size_t sz1 = 6,sz2 = 5;
  printf("%zu\n",maximum_frequency(arr1,sz1));
  printf("%zu\n",maximum_frequency(arr2,sz2));
  return 0;
}
