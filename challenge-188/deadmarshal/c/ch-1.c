#include<stdio.h>

int divisible_pairs(int *arr, size_t sz, int k)
{
  int count = 0;
  for(size_t i = 0; i < sz; ++i)
    for(size_t j = i+1; j < sz; ++j)
      if((arr[i] + arr[j]) % k == 0) count++;
  return count;
}

int main()
{
  int A1[4] = {4,5,1,6};
  int A2[4] = {1,2,3,4};
  int A3[4] = {1,3,4,5};
  int A4[4] = {5,1,2,3};
  int A5[4] = {7,2,4,2};
  size_t sz = 4;
  printf("%d\n", divisible_pairs(A1, sz, 2));
  printf("%d\n", divisible_pairs(A2, sz, 2));
  printf("%d\n", divisible_pairs(A3, sz, 3));
  printf("%d\n", divisible_pairs(A4, sz, 4));
  printf("%d\n", divisible_pairs(A5, sz, 4));
  return 0;
}
