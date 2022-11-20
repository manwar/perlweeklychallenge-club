#include<cstdio>
#include<vector>
#include<algorithm>

int twice_largest(std::vector<int>& vec)
{
  std::sort(vec.begin(), vec.end(), std::greater<int>());
  return vec[0] >= (2 * vec[1]) ? 1 : -1;
}

int main()
{
  std::vector<int> vec1{1,2,3,4};
  std::vector<int> vec2{1,2,0,5};
  std::vector<int> vec3{2,6,3,1};
  std::vector<int> vec4{4,5,2,3};
  printf("%2d\n", twice_largest(vec1));
  printf("%2d\n", twice_largest(vec2));
  printf("%2d\n", twice_largest(vec3));
  printf("%2d\n", twice_largest(vec4));
  return 0;
}

