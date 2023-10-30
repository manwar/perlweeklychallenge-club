#include<stdio.h>

int remove_one(int *arr, size_t sz)
{
  int c1 = 0, c2 = 0, idx1 = -1, idx2 = -1;
  for(size_t i = 1; i < sz; ++i)
  {
    if(arr[i] <= arr[i-1])
    {
      c1++;
      idx1 = i-1;
    }
  }
  for(size_t i = sz-2; i > 0; --i)
  {
    if(arr[i] >= arr[i+1])
    {
      c2++;
      idx2 = i+1;
    }
  }
  if((c1 == 1) && (c2 == 1) && (idx2 - idx1 + 1 == 2)) return 1;
  if((c1 > 1) || (c2 > 1)) return 0;
  return 1;
}

int main()
{
  int arr1[] = {0,2,9,4,5};
  int arr2[] = {5,1,3,2};
  int arr3[] = {2,2,3};
  size_t sz1 = 5, sz2 = 4, sz3 = 3;
  printf("%d\n",remove_one(arr1,sz1));
  printf("%d\n",remove_one(arr2,sz2));
  printf("%d\n",remove_one(arr3,sz3));
  return 0;
}

