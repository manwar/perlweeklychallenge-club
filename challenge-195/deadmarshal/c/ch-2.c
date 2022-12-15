#include<stdio.h>

int all_odd(int *arr, size_t sz)
{
  for(size_t i = 0; i < sz; ++i) if(arr[i] % 2 == 0) return 0;
  return 1;
}

int most_frequent_even(int *arr, size_t sz)
{
#define N 10
  if(all_odd(arr,sz)) return -1;
  int counts[N] = {0};
  for(size_t i = 0; i < sz; ++i) if(arr[i] % 2 == 0) counts[arr[i]]++;
  int maxkey = counts[0];
  for(size_t i = 1; i < N; ++i)
    if(counts[i] > maxkey) maxkey = i;
  return maxkey;
}

int main(void)
{
  int a1[] = {1,1,2,6,2};
  int a2[] = {1,3,5,7};
  int a3[] = {6,4,4,6,1};
  printf("%d\n", most_frequent_even(a1,5));
  printf("%d\n", most_frequent_even(a2,4));
  printf("%d\n", most_frequent_even(a3,5));
  return 0;
}

