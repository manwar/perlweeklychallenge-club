#include<stdio.h>

int is_prime(int n)
{
  int i = 5;
  if((n == 2) || (n == 3)) return 1;
  if((n <= 1) || (n % 2 == 0) || (n % 3 == 0)) return 0;
  while(i * i <= n)
  {
    if((n % i == 0) || (n % (i+2) == 0)) return 0;
    i += 6;
  }
  return 1;
}

int prime_count(int n)
{
  int count = 0;
  for(int i = 1; i < n; ++i) if(is_prime(i)) count++;
  return count;
}

int main(void)
{
  printf("%d\n", prime_count(10));
  printf("%d\n", prime_count(15));
  printf("%d\n", prime_count(1));
  printf("%d\n", prime_count(25));
}

