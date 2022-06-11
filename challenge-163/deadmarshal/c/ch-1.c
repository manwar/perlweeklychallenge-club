#include<stdio.h>

int sum_bitwise_operator(int* arr, size_t sz)
{
  int sum = 0;
  for(size_t i = 0; i < sz; ++i)
    for(size_t j = i+1; j < sz; ++j)
      sum += arr[i] & arr[j];
  return sum;
}

int main(void)
{
  int n1[] = {1,2,3};
  int n2[] = {2,3,4};
  size_t sz = 3; 
  printf("%d\n", sum_bitwise_operator(n1,sz));
  printf("%d\n", sum_bitwise_operator(n2,sz));
  return 0;
}
