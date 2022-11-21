#include<stdio.h>

int is_cute(int *arr, size_t sz)
{
  for(size_t i = 1; i <= sz; ++i)
    if((i % arr[i-1]) && (arr[i-1] % i)) return 0;
  return 1;
}

void swap(int *a, int *b)
{
  int temp = *a;
  *a = *b;
  *b = temp;
}

void permute(int *arr, int i, size_t sz, int *count)
{
  if(sz == i)
  {
    if(is_cute(arr, sz)) (*count)++;
    return;
  }
  for(size_t j = i; j < sz; ++j)
  {
    swap(arr+i,arr+j);
    permute(arr,i+1,sz,count);
    swap(arr+i,arr+j);
  }
  return;
}

int main(void)
{
  int arr[] = {1,2};
  int count = 0;
  permute(arr, 0, 2, &count);
  printf("%d\n", count);
  return 0;
}
