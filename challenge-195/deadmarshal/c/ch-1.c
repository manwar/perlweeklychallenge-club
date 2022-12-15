#include<stdio.h>

int has_dups(int n)
{
  int hash[10] = {0};
  if(n > 9999999999) return 1;
  while(n)
  {
    if(hash[n%10]) return 1;
    hash[n%10] = 1;
    n /= 10;
  }
  return 0;
}

int special_integers(int n)
{
  int count = 0;
  for(int i = 1; i <= n; ++i) if(!has_dups(i)) count++;
  return count;
}

int main()
{
  printf("%d\n",special_integers(15));
  printf("%d\n",special_integers(35));
  return 0;
}

