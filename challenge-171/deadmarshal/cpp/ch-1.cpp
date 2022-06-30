#include<iostream>
#include<vector>
#include<cmath>

template<typename T>
T divisors_sum(T n)
{
  T sum{};
  for(T i = 1; i < n / 2+1; ++i)
    if(n % i == 0) sum += i; 
  return sum;
}

template<typename T>
std::vector<T> abundant_odd_numbers()
{
  std::vector<T> vec{};
  int i = 1;
  do{
    if((divisors_sum(i) > i) && (i % 2 != 0)) vec.push_back(i);
    i++;
  }while(vec.size() != 20);
  return vec;
}

int main()
{
  std::vector<int> vec = abundant_odd_numbers<int>();
  for(const auto& e : vec)
    std::cout << e << ' ';
  std::cout << '\n';
  return 0;
}

