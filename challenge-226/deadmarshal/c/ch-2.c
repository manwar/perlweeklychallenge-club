#include<stdio.h>

void remove_dups(int *arr,size_t *sz)
{
  for(size_t i = 0; i < *sz; ++i)
  {
    for(size_t j = i+1; j < *sz;)
    {
      if(arr[j] == arr[i])
      {
	for(size_t k = j; k < *sz-1; ++k) arr[k] = arr[k+1];
	(*sz)--;
      }
      else j++;
    }
  }
}

size_t zero_array(int *arr,size_t sz)
{
  size_t count = 0;
  remove_dups(arr,&sz);
  for(size_t i = 0; i < sz; ++i)
  {
    if(arr[i] == 0) continue;
    count++;
  }
  return count;
}

int main()
{
  int arr1[] = {1,5,0,3,5};
  int arr2[] = {0};
  int arr3[] = {2,1,4,0,3};
  size_t sz1 = 5, sz2 = 1, sz3 = 5;
  printf("%zu\n", zero_array(arr1,sz1));
  printf("%zu\n", zero_array(arr2,sz2));
  printf("%zu\n", zero_array(arr3,sz3)); 
  return 0;
}

