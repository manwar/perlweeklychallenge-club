#include<stdio.h>

size_t arithmetic_triplets(int *arr,size_t sz,int diff)
{
  size_t count = 0;
  for(size_t i = 0; i < sz; ++i)
  {
    for(size_t j = i+1; j < sz; ++j)
    {
      for(size_t k = j+1; k < sz; ++k)
      {
	if((arr[j] - arr[i] == diff) && (arr[k] - arr[j] == diff))
	  count++;
      }
    }
  }
  return count;
}

int main(void)
{
  int arr1[] = {0,1,4,6,7,10};
  int arr2[] = {4,5,6,7,8,9};
  size_t sz1 = sizeof(arr1)/sizeof(*arr1);
  size_t sz2 = sizeof(arr2)/sizeof(*arr2);
  printf("%d\n", arithmetic_triplets(arr1,sz1,3));
  printf("%d\n", arithmetic_triplets(arr2,sz2,2));
  return 0;
}

