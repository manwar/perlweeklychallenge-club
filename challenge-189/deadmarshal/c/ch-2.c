#include<stdio.h>

void array_degree(int *arr, size_t sz)
{
  int left[10] = {0}, count[10] = {0};
  int x = 0, min = 0, max = 0, index = 0;
  
  for(size_t i = 0; i < sz; ++i)
  {
    x = arr[i];
    if(count[x] == 0)
    {
      left[x] = i;
      count[x] = 1;
    }
    else count[x]++;

    if(count[x] > max)
    {
      max = count[x];
      min = i - left[x] + 1;
      index = left[x];
    }
    else if((count[x] == max) && (i - left[x] + 1 < min))
    {
      min = i - left[x] + 1;
      index = left[x];
    }
  }

  for(size_t i = index; i < (index+min); ++i)
    printf("%d ", arr[i]);
  puts("");
}

int main(void)
{
  int a1[4] = {1,3,3,2};
  int a2[4] = {1,2,1,3};
  int a3[5] = {1,3,2,1,2};
  int a4[5] = {1,1,2,3,2};
  int a5[5] = {2,1,2,1,1};
  size_t sz1 = 4, sz2 = 5;
  array_degree(a1, sz1);
  array_degree(a2, sz1);
  array_degree(a3, sz2);
  array_degree(a4, sz2);
  array_degree(a5, sz2);
  return 0;
}
  
