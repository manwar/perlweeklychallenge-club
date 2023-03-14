#include<iostream>
#include<vector>

int h_index(const std::vector<int> &vec)
{
  int ret{};
  for(int i = 0; i < vec.size(); ++i)
    if(i >= vec[i])
    {
      ret = i;
      break;
    }
  return ret;
}

int main()
{
  std::cout << h_index({10,8,5,4,3}) << '\n';
  std::cout << h_index({25,8,5,3,3}) << '\n';
  return 0;
}

