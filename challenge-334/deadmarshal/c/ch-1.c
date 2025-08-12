#include<stdio.h>
#include<assert.h>

int range_sum(const int *arr,const size_t sz,
	      const size_t x,const size_t y)
{
  assert(x >= 0 && y < sz && "x or y is out of bounds!");
  int sum = 0;
  for(size_t i = x; i <= y; ++i) sum += arr[i];
  return sum;
}

int main(void)
{
  const int arr1[] = {-2,0,3,-5,2,-1};
  const int arr2[] = {1,-2,3,-4,5};
  const int arr3[] = {1,0,2,-1,3};
  const int arr4[] = {-5,4,-3,2,-1,0};
  const int arr5[] = {-1,0,2,-3,-2,1};
  const size_t sz1 = 6,sz2 = 5,sz3 = 5,sz4 = 6,sz5 = 6;
  printf("%d\n",range_sum(arr1,sz1,0,2));
  printf("%d\n",range_sum(arr2,sz2,1,3));
  printf("%d\n",range_sum(arr3,sz3,3,4));
  printf("%d\n",range_sum(arr4,sz4,0,3));
  printf("%d\n",range_sum(arr5,sz5,0,2));
  return 0;
}

