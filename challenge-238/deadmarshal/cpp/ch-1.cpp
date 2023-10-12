#include<iostream>
#include<vector>
#include<numeric>
#include<iterator>

template<typename T>
void running_sum(const std::vector<T> &vec)
{
  std::vector<T> ret{};
  std::partial_sum(vec.cbegin(),vec.cend(),
		   std::ostream_iterator<T>(std::cout, " "));
  std::cout << '\n';
}

int main(void)
{
  std::vector<int> vec1{1,2,3,4,5},vec2{1,1,1,1,1},vec3{0,-1,1,2};
  running_sum<int>(vec1);
  running_sum<int>(vec2);
  running_sum<int>(vec3);
  return 0;
}

