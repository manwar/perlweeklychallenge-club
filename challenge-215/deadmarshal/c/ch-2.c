#include<stdio.h>

int number_placement(int *arr, size_t sz, size_t count)
{
  size_t c = 0;
  for(size_t i = 1; i < sz-1; ++i)
    if(arr[i-1] == 0 && arr[i+1] == 0) c++;
  return c >= count;
}

int main(void)
{
  int a1[] = {1,0,0,0,1};
  int a2[] = {1,0,0,0,1};
  int a3[] = {1,0,0,0,0,0,0,0,1};
  size_t sz1 = 5, sz2 = 5, sz3 = 9;
  printf("%d\n", number_placement(a1,sz1,1));
  printf("%d\n", number_placement(a2,sz2,2));
  printf("%d\n", number_placement(a3,sz3,3)); 
  return 0;
}

