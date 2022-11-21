#include<stdio.h>
#include<stdlib.h>

int compare(const void *a, const void *b)
{ 
  int i1 = *(int*)a;
  int i2 = *(int*)b;
  return i2 - i1;
}

int twice_largest(int *arr, size_t sz)
{
  qsort(arr, sz, sizeof(int), compare);
  return arr[0] >= (2 * arr[1]) ? 1 : -1;
}

int main(void)
{
  int a1[4] = {1,2,3,4};
  int a2[4] = {1,2,0,5};
  int a3[4] = {2,6,3,1};
  int a4[4] = {4,5,2,3};
  size_t sz = 4;
  printf("%2d\n", twice_largest(a1, sz));
  printf("%2d\n", twice_largest(a2, sz));
  printf("%2d\n", twice_largest(a3, sz));
  printf("%2d\n", twice_largest(a4, sz)); 
  return 0;
}
