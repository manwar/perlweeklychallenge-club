#include<iostream>
#include<vector>
#include<set>

template<typename T>
bool is_disjoint(const std::set<T> &s1,
		 const std::set<T> &s2)
{
  for(auto it = s1.cbegin(); it != s1.cend(); ++it)
    if(s2.count(*it)) return false;
  return true;
}

template<typename T>
bool disjoint_sets(const std::vector<T> &vec1,
		   const std::vector<T> &vec2)
{
  return is_disjoint<T>({vec1.cbegin(),vec1.cend()},
			{vec2.cbegin(),vec2.cend()});
}

int main()
{
  std::vector<int> vec1{1,2,5,3,4},vec2{4,6,7,8,9};
  std::vector<int> vec3{1,3,5,7,9},vec4{0,2,4,6,8};
  std::cout << std::boolalpha << disjoint_sets<int>(vec1,vec2) << '\n'
	    << disjoint_sets<int>(vec3,vec4) << '\n';
  return 0;
}

