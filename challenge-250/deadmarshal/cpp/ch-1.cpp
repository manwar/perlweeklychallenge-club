#include<iostream>
#include<vector>

template<typename T>
int smallest_index(const std::vector<T> &vec)
{
  for(size_t i = 0; i < vec.size(); ++i) if(i % 10 == vec.at(i)) return i;
  return -1;
}
  
int main()
{
  std::vector<int> vec1{0,1,2},vec2{4,3,2,1},vec3{1,2,3,4,5,6,7,8,9,0};
  std::cout << smallest_index<int>(vec1) << '\n'
	    << smallest_index<int>(vec2) << '\n'
	    << smallest_index<int>(vec3) << '\n';
  return 0;
}

