#include<stdio.h>
#include<assert.h>

int disjoint_sets(int *arr1,int *arr2, size_t sz)
{
  int hash[10] = {0};
  for(size_t i = 0; i < sz; ++i)
  {
    hash[arr1[i] % 10]++;
    hash[arr2[i] % 10]++;
  }
  for(size_t i = 0; i < 10; ++i) if(hash[i] > 1) return 0;
  return 1;
}

int main(void)
{
  int arr1[] = {1,2,5,3,4};
  int arr2[] = {4,6,7,8,9};
  int arr3[] = {1,3,5,7,9};
  int arr4[] = {0,2,4,6,8};
  const size_t sz = 5;
  printf("%d\n",disjoint_sets(arr1,arr2,sz));
  printf("%d\n",disjoint_sets(arr3,arr4,sz));
  return 0;
}

