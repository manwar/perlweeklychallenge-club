#include<iostream>
#include<vector>

int sum_bitwise_operator(std::vector<int>& vec)
{
  int sum{};
  for(std::size_t i{}; i < vec.size(); ++i)
    for(std::size_t j{i+1}; j < vec.size(); ++j)
      sum += vec[i] & vec[j];
  return sum;
}

int main()
{
  std::vector<int> vec{1,2,3};
  std::vector<int> vec2{2,3,4};
  std::cout << sum_bitwise_operator(vec) << '\n';
  std::cout << sum_bitwise_operator(vec2) << '\n';
  return 0;
}
