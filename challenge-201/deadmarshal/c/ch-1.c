#include<stdio.h>
#include<stdlib.h>

void missing_numbers(int *arr, size_t sz)
{
  int hash[10] = {0};
  for(size_t i = 0; i < sz; ++i) hash[arr[i] % 10] = 1;
  for(size_t i = 0; i <= sz; ++i)
    if(hash[i] != 1) printf("%d ",i);
  puts("");
}

int main(void)
{
  int a1[3] = {0,1,3};
  int a2[2] = {0,1};
  size_t sz1 = 3,sz2 = 2;
  missing_numbers(a1,sz1);
  missing_numbers(a2,sz2);
}

