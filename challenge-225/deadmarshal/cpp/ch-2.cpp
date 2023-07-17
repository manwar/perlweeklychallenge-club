#include<iostream>
#include<vector>

template<typename T>
void left_right_sum_diff(const std::vector<T> &vec)
{
  std::size_t left{},right{};
  for(std::size_t i = 1; i < vec.size(); ++i) right += vec.at(i);
  for(std::size_t i = 0; i < vec.size(); ++i)
  {
    std::cout << abs(left - right) << ' ';
    left += vec.at(i);
    right -= i < vec.size()-1 ? vec.at(i+1) : 0;
  }
  std::cout << '\n';
}

int main()
{
  std::vector<int> vec1{10,4,8,3},vec2{1},vec3{1,2,3,4,5};
  left_right_sum_diff<int>(vec1);
  left_right_sum_diff<int>(vec2);
  left_right_sum_diff<int>(vec3);
  return 0;
}

