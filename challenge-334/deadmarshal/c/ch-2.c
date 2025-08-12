#include<stdio.h>
#include<stdlib.h>
#include<limits.h>

int nearest_valid_point(const int arr[][2],
			const size_t sz,
			const int x,
			const int y)
{
  int res = -1, min = INT_MAX;
  for(size_t i = 0; i < sz; ++i) {
    int a = arr[i][0], b = arr[i][1];
    if((a == x) || (b == y)) {
      int d = abs(a - x) + abs(b - y);
      if(d < min) {
	min = d;
	res = i;
      }
    }
  }
  return res;
}

int main(void)
{
  const int arr1[][2] = {{1,2},{3,1},{2,4},{2,3}};
  const int arr2[][2] = {{3,4},{2,3},{1,5},{2,5}};
  const int arr3[][2] = {{2,2},{3,3},{4,4}};
  const int arr4[][2] = {{0,1},{1,0},{0,2},{2,0}};
  const int arr5[][2] = {{5,6},{6,5},{5,4},{4,5}};
  const size_t sz1 = 4,sz2 = 4,sz3 = 3,sz4 = 4,sz5 = 4;
  printf("%d\n",nearest_valid_point(arr1,sz1,3,4));
  printf("%d\n",nearest_valid_point(arr2,sz2,2,5));
  printf("%d\n",nearest_valid_point(arr3,sz3,1,1));
  printf("%d\n",nearest_valid_point(arr4,sz4,0,0));
  printf("%d\n",nearest_valid_point(arr5,sz5,5,5));
  return 0;
}

