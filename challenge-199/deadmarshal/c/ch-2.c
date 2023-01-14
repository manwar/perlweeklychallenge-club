#include<stdio.h>
#include<stdlib.h>

int good_triplets(int *arr, size_t sz, int x, int y, int z)
{
  int count = 0;
  for(size_t i = 0; i < sz; ++i)
    for(size_t j = 0; j < sz; ++j)
      for(size_t k = 0; k < sz; ++k)
	if((abs(arr[i] - arr[j]) <= x) &&
	   (abs(arr[j] - arr[k]) <= y) &&
	   (abs(arr[i] - arr[k]) <= z) &&
	   (0 <= i) &&
	   (i < j) &&
	   (j < k) &&
	   (k <= sz)) count++;
  return count;
}

int main(void)
{
  int a1[] = {3,0,1,1,9,7};
  int a2[] = {1,1,2,2,3};
  size_t sz1 = 6, sz2 = 5;
  printf("%d\n", good_triplets(a1,sz1,7,2,3));
  printf("%d\n", good_triplets(a2,sz2,0,0,1));
  return 0;
}

