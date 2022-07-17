#include<stdio.h>

int uabs(int a, int b)
{
  if(a < b) return b - a;
  return a - b;
}

int is_esthetic_number(int n)
{
  if(n == 0) return 0;
  int i = n % 10;
  n /= 10;
  while(n)
  {
    int j = n % 10;
    if(uabs(i, j) != 1) return 0;
    n /= 10;
    i = j;
  }
  return 1;
}

int main(void)
{
  printf("Is %d an esthetic number? %s\n",
	 5456,
	 is_esthetic_number(5456) ? "true" : "false");
  printf("Is %d an esthetic number? %s\n",
	 120,
	 is_esthetic_number(120) ? "true" : "false");
  
  return 0;
}
