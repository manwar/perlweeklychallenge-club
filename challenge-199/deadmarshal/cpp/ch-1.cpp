#include<iostream>
#include<vector>

template<typename T>
int good_pairs(const std::vector<T> &vec)
{
  int count{};
  for(size_t i = 0; i < vec.size(); ++i)
    for(size_t j = i+1; j < vec.size(); ++j)
      if(vec[i] == vec[j]) count++;
  return count;
}

int main()
{
  std::vector<int> vec1{1,2,3,1,1,3},vec2{1,2,3},vec3{1,1,1,1};
  std::cout << good_pairs<int>(vec1) << '\n';
  std::cout << good_pairs<int>(vec2) << '\n';
  std::cout << good_pairs<int>(vec3) << '\n';
  return 0;
}

