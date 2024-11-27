#include<iostream>
#include<vector>
#include<unordered_set>

template<typename T>
int consecutive_sequence(const std::vector<T> &vec)
{
  std::unordered_set<T> s{};
  int res = 0;
  for(const auto &e : vec) s.insert(e);
  for(const auto &e : vec)
  {
    if(s.find(e-1) == s.end())
    {
      int j = e;
      while(s.find(j) != s.end()) j++;
      res = std::max(res,j-e);
    }
  }
  return res == 1 ? -1 : res;
}

int main()
{
  std::vector<int> vec1{10,4,20,1,3,2},
    vec2{0,6,1,8,5,2,4,3,0,7},
    vec3{10,30,20};
  std::cout << consecutive_sequence<int>(vec1) << '\n'
	    << consecutive_sequence<int>(vec2) << '\n'
	    << consecutive_sequence<int>(vec3) << '\n';
  return 0;
}

