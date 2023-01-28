#include<iostream>
#include<vector>
#include<unordered_map>

template<typename T>
void missing_numbers(const std::vector<T> &vec)
{
  std::unordered_map<T,T> m{};
  for(size_t i = 0; i < vec.size(); ++i) m[vec[i]] = 1;
  for(size_t i = 0; i < vec.size()+1; ++i)
    if(m[i] != 1) std::cout << i << ' ';
  std::cout << '\n';
}

int main()
{
  const std::vector<int> vec1{0,1,3},vec2{0,1};
  missing_numbers<int>(vec1);
  missing_numbers<int>(vec2);    
  return 0;
}

