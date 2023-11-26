#include<stdio.h>
#include<stdlib.h>

int product(int n)
{
  int prod = 1;
  while(n)
  {
    prod *= n % 10;
    n /= 10;
  }
  return prod;
}

int helper(int n)
{
  int sum = 0;
  while(n >= 10)
  {
    sum++;
    n = product(n);
  }
  return sum;
}

int compare(const void *a, const void *b)
{
  int ha = helper(*(int*)a);
  int hb = helper(*(int*)b);
  return ha == hb ? *(int*)a - *(int*)b : ha - hb;
}

void persistence_sort(int *arr,size_t sz)
{
  qsort(arr,sz,sizeof(*arr),compare);
  for(size_t i = 0; i < sz; ++i) printf("%d ", arr[i]);
  puts("");
}

int main(void)
{
  int arr1[] = {15,99,1,34};
  int arr2[] = {50,25,33,22};
  size_t sz1 = 4, sz2 = 4;
  persistence_sort(arr1,sz1);
  persistence_sort(arr2,sz2);
  return 0;
}

