#include<iostream>
#include<vector>

template<typename T>
void build_array(const std::vector<T> &vec)
{
  std::vector<T> ret(vec.size(),0);
  for(size_t i = 0; i < vec.size(); ++i) ret.at(i) = vec.at(vec.at(i));
  for(size_t i = 0; i < ret.size(); ++i)
    std::cout << ret.at(i) << ' ';
  std::cout << '\n';
}

int main()
{
  std::vector<int> vec1 = {0,2,1,5,3,4};
  std::vector<int> vec2 = {5,0,1,2,3,4};
  build_array<int>(vec1);
  build_array<int>(vec2);
  return 0;
}

