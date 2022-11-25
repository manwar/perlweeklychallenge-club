#include<stdio.h>
#include<stdlib.h>

int array_sum(int *arr, size_t sz)
{
  int sum = 0;
  for(size_t i = 0; i < sz; ++i)
    sum += arr[i];
  return sum;
}

int equal_distribution(int *arr, size_t sz)
{
  int sum,avg,moves = 0,sum_part = 0;
  sum = array_sum(arr,sz);
  if(sum % sz == 0)
  {
    avg = (int)sum / sz;
    for(size_t i = 0; i < sz; ++i)
    {
      sum_part += arr[i];
      moves += abs(sum_part - (avg * (i+1)));
    }
    return moves;
  }
  return -1;
}

int main(void)
{
  int a1[] = {1,0,5};
  int a2[] = {0,2,0};
  int a3[] = {0,3,0};
  size_t sz = 3;
  printf("%d\n", equal_distribution(a1,sz));
  printf("%d\n", equal_distribution(a2,sz));
  printf("%d\n", equal_distribution(a3,sz));
  return 0;
}
