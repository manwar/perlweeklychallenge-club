#include<iostream>
#include<vector>

template<typename T>
std::size_t reverse_pairs(const std::vector<T> &vec)
{
  std::size_t count{};
  for(std::size_t i = 0; i < vec.size()-1; ++i)
    for(std::size_t j = i+1; j < vec.size(); ++j)
      if(vec.at(i) > (2 * vec.at(j))) count++;
  return count;
}

int main()
{
  std::vector<int> vec1{1,3,2,3,1},vec2{2,4,3,5,1};
  std::cout << reverse_pairs<int>(vec1) << '\n'
	    << reverse_pairs<int>(vec2) << '\n';
  return 0;
}

