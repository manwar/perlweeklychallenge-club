#include<iostream>
#include<cmath>

int reverse_num(int n)
{
  int rev{}, rem;
  while(n)
  {
    rem = n % 10;
    rev = rem + (rev * 10);
    n /= 10;
  }
  return rev;
}

bool is_prime(int n)
{
  if(n <= 1) return false;
  for(int i{2}; i <= (int)sqrt(n); ++i)
    if(n % i == 0) return false;
  return true;
}

int main()
{
  for(int i{}; i < 1000; ++i)
    if((i == reverse_num(i)) && (is_prime(i)))
      std::cout << i << ' ';
  return 0;
}
