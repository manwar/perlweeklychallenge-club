#include<iostream>
#include<vector>

int summations(std::vector<int> vec)
{
  for(std::size_t i{}; i < vec.size(); ++i)
    for(std::size_t j{i+1}; j < vec.size(); ++j)
      vec[j+1] = vec[j] + vec[j+1];
  return vec.back();
}

int main()
{
  std::vector<int> vec{1,2,3,4,5};
  std::vector<int> vec2{1,3,5,7,9};
  std::cout << summations(vec) << '\n';
  std::cout << summations(vec2) << '\n';
  return 0;
}
