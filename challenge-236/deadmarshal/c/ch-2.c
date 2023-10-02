#include<stdio.h>
#include<stdlib.h>
#include<string.h>

size_t array_loops(int *arr,size_t sz)
{
  size_t count = 0;
  int *indices = malloc(sz*sizeof(*arr));
  memset(indices,-1,sz*sizeof(*arr));
  for(size_t i = 0; i < sz; ++i)
  {
    if(indices[i] == -1)
    {
      count++;
      while(indices[i] == -1)
      {
	indices[i] = 1;
	i = arr[i];
      }
    }
  }
  free(indices);
  return count;
}

int main(void)
{
  int arr1[] = {4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10};
  int arr2[] = {0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19};
  int arr3[] = {9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17};
  const size_t sz1 = 20,sz2 = 20,sz3 = 20;
  printf("%zu\n",array_loops(arr1,sz1));
  printf("%zu\n",array_loops(arr2,sz2));
  printf("%zu\n",array_loops(arr3,sz3));
  return 0;
}

