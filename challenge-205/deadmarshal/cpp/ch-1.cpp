#include<iostream>
#include<vector>
#include<algorithm>

template<typename T>
int third_highest(std::vector<T> &vec)
{
  std::sort(vec.begin(),vec.end(),std::greater<T>());
  vec.erase(std::unique(vec.begin(),vec.end()),vec.end());
  if(vec.size() < 3) return vec[0];
  return vec[2];
}

int main()
{
  std::vector<int> vec1{5,3,4},vec2{5,6},vec3{5,4,4,3};
  std::cout << third_highest<int>(vec1) << '\n';
  std::cout << third_highest<int>(vec2) << '\n';
  std::cout << third_highest<int>(vec3) << '\n';
  return 0;
}

