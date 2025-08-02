#include<stdio.h>

int unique_number(int *arr, size_t sz)
{
  int hash[10] = {0};
  for(size_t i = 0; i < sz; ++i) hash[arr[i] % 10]++;
  for(size_t i = 0; i < 10; ++i) if(hash[i] == 1) return i;
  return -1;
}

int main(void)
{
  int arr1[] = {3,3,1};
  int arr2[] = {3,2,4,2,4};
  int arr3[] = {1};
  int arr4[] = {4,3,1,1,1,4};
  size_t sz1 = 3,sz2 = 5,sz3 = 1,sz4 = 6;
  printf("%d\n",unique_number(arr1,sz1));
  printf("%d\n",unique_number(arr2,sz2));
  printf("%d\n",unique_number(arr3,sz3));
  printf("%d\n",unique_number(arr4,sz4));
  return 0;
}

