#include<stdio.h>
#include<math.h>

int binary_flip(int n)
{
  return (~n) & ((int)pow(2,log(n)/log(2))-1);
}

int main(void)
{
  printf("%d\n", binary_flip(5));
  printf("%d\n", binary_flip(4));
  printf("%d\n", binary_flip(6));
  return 0;
}
