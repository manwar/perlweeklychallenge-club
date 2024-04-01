#include<iostream>
#include<vector>

template<typename T>
std::size_t count_equal_divisible(const std::vector<T> &vec,int k)
{
  size_t count{};
  for(size_t i = 0; i < vec.size()-1; ++i)
    for(size_t j = i+1; j < vec.size(); ++j)
      if((vec.at(i) == vec.at(j)) && ((i*j) % k == 0)) count++;
  return count;
}

int main()
{
  std::vector<int> vec1{3,1,2,2,2,1,3},vec2{1,2,3};
  std::cout << count_equal_divisible<int>(vec1,2) << '\n'
	    << count_equal_divisible<int>(vec2,1) << '\n';
  return 0;
}

