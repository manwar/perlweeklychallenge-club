#include<iostream>

int total_zero(int x, int y)
{
  int count{};
  while((x > 0) && (y > 0))
  {
    (x >= y) ? (x -= y) : (y -= x);
    count++;
  }
  return count;
}

int main()
{
  std::cout << total_zero(5,4) << '\n';
  std::cout << total_zero(4,6) << '\n';
  std::cout << total_zero(2,5) << '\n';
  std::cout << total_zero(3,1) << '\n';
  std::cout << total_zero(7,4) << '\n';  
  return 0;
}

