#include<iostream>
#include<vector>

bool number_placement(const std::vector<int> &vec, size_t count)
{
  size_t c = 0;
  for(size_t i = 1; i < vec.size()-1; ++i)
    if(vec[i-1] == 0 && vec[i+1] == 0) c++;
  return c >= count;
}

int main()
{
  std::vector<int> vec1{1,0,0,0,1},
    vec2{1,0,0,0,1},
    vec3{1,0,0,0,0,0,0,0,1};
  std::cout << std::boolalpha << number_placement(vec1,1) << '\n';
  std::cout << std::boolalpha << number_placement(vec2,2) << '\n';
  std::cout << std::boolalpha << number_placement(vec3,3) << '\n';
  return 0;
}

