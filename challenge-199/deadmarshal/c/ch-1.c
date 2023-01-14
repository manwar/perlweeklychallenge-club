#include<stdio.h>

int good_pairs(int *arr, size_t sz)
{
  int count = 0;
  for(size_t i = 0; i < sz; ++i)
    for(size_t j = i+1; j < sz; ++j)
      if(arr[i] == arr[j]) count++;
  return count;
}

int main(void)
{
  int a1[] = {1,2,3,1,1,3};
  int a2[] = {1,2,3};
  int a3[] = {1,1,1,1};
  size_t sz1 = 6, sz2 = 3, sz3 = 4;
  printf("%d\n", good_pairs(a1,sz1));
  printf("%d\n", good_pairs(a2,sz2));
  printf("%d\n", good_pairs(a3,sz3));
  return 0;
}

