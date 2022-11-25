#include<iostream>
#include<cmath>

int binary_flip(int n)
{
  return (~n) & ((int)pow(2,log(n)/log(2))-1);
}

int main(void)
{
  std::cout << binary_flip(5) << '\n';
  std::cout << binary_flip(4) << '\n';
  std::cout << binary_flip(6) << '\n';
  return 0;
}
