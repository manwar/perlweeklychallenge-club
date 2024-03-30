#include<stdio.h>
#include<math.h>

size_t max_positive_negative(int *arr,size_t sz)
{
  size_t neg = 0, pos = 0;
  for(size_t i = 0; i < sz; ++i) if(arr[i] < 0) neg++; else pos++;
  return (size_t)fmax(neg,pos);
}

int main(void)
{
  int arr1[] = {-3,1,2,-1,3,-2,4};
  int arr2[] = {-1,-2,-3,1};
  int arr3[] = {1,2};
  size_t sz1 = 7, sz2 = 4, sz3 = 2;
  printf("%zu\n",max_positive_negative(arr1,sz1));
  printf("%zu\n",max_positive_negative(arr2,sz2));
  printf("%zu\n",max_positive_negative(arr3,sz3));
  return 0;
}

