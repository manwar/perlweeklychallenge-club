#include<iostream>
#include<vector>

template<typename T>
std::size_t max_positive_negative(const std::vector<T> &vec)
{
  std::size_t neg{},pos{};
  for(const T& e : vec) if(e < 0) neg++; else pos++;
  return static_cast<size_t>(std::max(neg,pos));
}

int main()
{
  std::vector<int> vec1{-3,1,2,-1,3,-2,4},
    vec2{-1,-2,-3,1},vec3{1,2};
  std::cout << max_positive_negative<int>(vec1) << '\n'
	    << max_positive_negative<int>(vec2) << '\n'
	    << max_positive_negative<int>(vec3) << '\n';
  return 0;
}

