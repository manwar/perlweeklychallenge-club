#include<stdio.h>

int digit_count_value(int *arr,size_t sz)
{
  int hash[10] = {0};
  for(size_t i = 0; i < sz; ++i) hash[arr[i] % 10]++;
  for(size_t i = 0; i < sz; ++i) if(hash[i] != arr[i]) return 0;
  return 1;
}

int main(void)
{
  int arr1[] = {1,2,1,0};
  int arr2[] = {0,3,0};
  size_t sz1 = 4,sz2 = 3;
  printf("%d\n",digit_count_value(arr1,sz1));
  printf("%d\n",digit_count_value(arr2,sz2));
  return 0;
}

