#include<iostream>
#include<vector>

template<typename T>
std::size_t floor_sum(const std::vector<T> &vec)
{
  std::size_t sum{};
  for(std::size_t i{}; i < vec.size(); ++i)
    for(std::size_t j{}; j < vec.size(); ++j)
      sum += static_cast<std::size_t>(vec.at(i) / vec.at(j));
  return sum;
}

int main()
{
  std::vector<int> vec1{2,5,9},vec2{7,7,7,7,7,7,7};
  std::cout << floor_sum<int>(vec1) << '\n'
	    << floor_sum<int>(vec2) << '\n';
  return 0;
}

