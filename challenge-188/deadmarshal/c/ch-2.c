#include<stdio.h>

int total_zero(int x, int y)
{
  int count = 0;
  while((x > 0) && (y > 0))
  {
    (x >= y) ? (x -= y) : (y -= x);
    count++;
  }
  return count;
}

int main()
{
  printf("%d\n", total_zero(5,4));
  printf("%d\n", total_zero(4,6));
  printf("%d\n", total_zero(2,5));
  printf("%d\n", total_zero(3,1));
  printf("%d\n", total_zero(7,4));  
  return 0;
}
