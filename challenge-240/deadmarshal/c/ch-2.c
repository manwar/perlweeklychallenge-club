#include<stdio.h>
#include<stdlib.h>

void build_array(int *arr,size_t sz)
{
  int *ret = malloc(sz * sizeof(*arr));
  for(size_t i = 0; i < sz; ++i) ret[i] = arr[arr[i]];
  for(size_t i = 0; i < sz; ++i) printf("%d ",ret[i]);
  puts("");
  free(ret);
}

int main(void)
{
  int arr1[] = {0,2,1,5,3,4};
  int arr2[] = {5,0,1,2,3,4};
  size_t sz1 = 6,sz2 = 6;
  build_array(arr1,sz1);
  build_array(arr2,sz2);
  return 0;
}

