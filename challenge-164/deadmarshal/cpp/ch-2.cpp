#include<iostream>
#include<unordered_map>
#include<cmath>

int sum_squares(int n)
{
  int sum{};
  while(n)
  {
    sum += (int)std::pow(n % 10, 2);
    n /= 10;
  }
  return sum;
}

bool is_happy(int n)
{
  std::unordered_map<int, int> map{};
  while(1)
  {
    map[n]++;
    n = sum_squares(n);
    if(n == 1) return true;
    if(map[n] != 0) return false;
  }
}

void happy_numbers()
{
  int i{}, count{};
  while(count < 8)
  {
    if(is_happy(i))
    {
      std::cout << i << ' ';
      count++;
    }
    i++;
  }
}

int main()
{
  happy_numbers();
  return 0;
}
