#include<iostream>

bool is_prime(int n)
{
  int i = 5;
  if((n == 2) || (n == 3)) return true;
  if((n <= 1) || (n % 2 == 0) || (n % 3 == 0)) return false;
  while(i * i <= n)
  {
    if((n % i == 0) || (n % (i+2) == 0)) return false;
    i += 6;
  }
  return true;
}

int prime_count(int n)
{
  int count = 0;
  for(int i = 1; i < n; ++i) if(is_prime(i)) count++;
  return count;
}

int main()
{
  std::cout << prime_count(10) << '\n';
  std::cout << prime_count(15) << '\n';
  std::cout << prime_count(1) << '\n';
  std::cout << prime_count(25) << '\n';
}

