#include<iostream>
#include<vector>
#include<unordered_map>
#include<algorithm>

template<typename T>
std::ostream &operator<<(std::ostream &os,
			 const std::vector<T>& vec)
{
  for(const auto &e : vec) os << e << ' ';
  os << "\n";
  return os;
}

template<typename T>
void frequency_sort(std::vector<T>& vec)
{
  std::unordered_map<T,T> m{};
  for(const auto& e : vec) m[e]++;
  std::sort(vec.begin(),vec.end(),[&m](const T& a, const T& b){
    return m[a] == m[b] ? b < a : m[a] < m[b];
  });
  std::cout << vec;
}

int main()
{
  std::vector<int> vec1{1,1,2,2,2,3},
    vec2{2,3,1,3,2},vec3{-1,1,-6,4,5,-6,1,4,1};
  frequency_sort<int>(vec1);
  frequency_sort<int>(vec2);
  frequency_sort<int>(vec3);
  return 0;
}

