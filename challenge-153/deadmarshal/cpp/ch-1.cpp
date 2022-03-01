#include<iostream>

int factorial(int n)
{
  if(n == 0) return 1;
  else return n * factorial(n-1);
}

long long left_factorial(int n)
{
  long long sum = 0;
  for(int k = 0; k < n; k++)
    sum += factorial(k);
  return sum;
}

int main()
{
  for(int i = 1; i <= 10; i++)
    std::cout << left_factorial(i) << ' ';
  std::cout << '\n';
  
  return 0;
}
