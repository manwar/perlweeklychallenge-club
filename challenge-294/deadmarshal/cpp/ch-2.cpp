#include<iostream>
#include<vector>
#include<algorithm>

template<typename T>
std::ostream &operator<<(std::ostream& os,const std::vector<T> vec)
{
  for(const auto &e : vec) os << e << ' ';
  os << '\n';
  return os;
}

int main()
{
  std::vector<int> vec1{1,2,3},vec2{2,1,3},vec3{3,1,2};
  std::next_permutation(vec1.begin(),vec1.end());
  std::next_permutation(vec2.begin(),vec2.end());
  std::next_permutation(vec3.begin(),vec3.end());
  std::cout << vec1 << vec2 << vec3;
}

