#include<stdio.h>
#include<stdlib.h>

#define N 5
static int count = 0;

void find_combinations(int *arr,
			    int index,
			    int num,
			    int reduced_num)
{
  if(reduced_num < 0) return;
  if(reduced_num == 0)
  {
    count++;
    return;
  }
  int prev = index == 0 ? 1 : arr[index-1];
  for(int i = prev; i <= num; ++i)
  {
    arr[index] = i;
    find_combinations(arr,index+1,num,reduced_num-i);
  }
}

int main(void)
{
  int arr[N];
  find_combinations(arr,0,N,N);
  printf("%d\n",count);
}  

