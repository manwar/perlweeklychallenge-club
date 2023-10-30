#include<stdio.h>
#include<stdlib.h>

int *duplicate_zeros(int *arr, size_t sz)
{
  int *ret = malloc(sz * sizeof(*arr));
  size_t i = 0,j = 0;
  while(j < sz)
  {
    if(arr[i] == 0)
    {
      ret[j] = 0;
      ret[++j] = 0;
      ++i;
      ++j;
    }
    else ret[j++] = arr[i++];
  }
  return ret;
}

void print_array(int *arr, size_t sz)
{
  for(size_t i = 0; i < sz; ++i) printf("%d ",arr[i]);
  puts("");
}

int main()
{
  int arr1[] = {1,0,2,3,0,4,5,0};
  int arr2[] = {1,2,3};
  int arr3[] = {0,3,0,4,5};
  size_t sz1 = 8, sz2 = 3, sz3 = 5;
  int *ret1 = duplicate_zeros(arr1,sz1);
  int *ret2 = duplicate_zeros(arr2,sz2);
  int *ret3 = duplicate_zeros(arr3,sz3);
  print_array(ret1,sz1);
  print_array(ret2,sz2);
  print_array(ret3,sz3);
  free(ret1);
  free(ret2);
  free(ret3);
  return 0;
}

