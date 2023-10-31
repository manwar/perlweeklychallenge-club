#include<stdio.h>
#include<stdlib.h>

size_t count_factors(int n)
{
  size_t count = 0;
  int c = 2;
  while(n > 1)
  {
    if(n % c == 0)
    {
      n /= c;
      count++;
    }
    else c++;
  }
  return count;
}

int compare(const void *a, const void *b)
{
  size_t fa = count_factors(*(int*)a);
  size_t fb = count_factors(*(int*)b);
  return fa == fb ? a - b : fa - fb;
}

void prime_order(int *arr,size_t sz)
{
  qsort(arr,sz,sizeof(*arr),compare);
}

int main(void)
{
  int arr[] = {11,8,27,4};
  size_t sz = sizeof(arr)/sizeof(*arr);
  prime_order(arr,sz);
  for(size_t i = 0; i < sz; ++i) printf("%d ",arr[i]);
  puts("");
  return 0;
}

