#include<stdio.h>
#include<stdlib.h>

int compare(const void *a, const void *b)
{ 
  int i1 = *(int*)a;
  int i2 = *(int*)b;
  return i1 - i2;
}

int max_gap(int *arr, size_t sz)
{
  if(sz < 2) return 0;
  qsort(arr,sz,sizeof(int),compare); 
  size_t i = 0;
  int max = 0, count = 0, temp = 0;
  while(i < sz)
  {
    temp = abs(arr[i] - arr[i+1]);
    if(temp > max) max = temp;
    i += 2;
  }
  for(i = 0; i < sz-1; ++i)
    if(abs(arr[i] - arr[i+1]) == max) count++;
  return count;
}

int main(void)
{
  int a1[] = {2,5,8,1};
  int a2[] = {3};
  size_t sz1 = 4, sz2 = 1;
  printf("%d\n",max_gap(a1,sz1));
  printf("%d\n",max_gap(a2,sz2));
  return 0;
}

