#include<iostream>
#include<vector>

template<typename T>
int maximum_xor(const std::vector<T> &vec)
{
  int max = 0;
  for(size_t i = 0; i < vec.size(); ++i)
    for(size_t j = 0; j < vec.size(); ++j)
    {
      int temp = vec[i] ^ vec[j];
      if(max < temp) max = temp;
    }
  return max;
}

int main()
{
  std::cout << maximum_xor<int>({1,2,3,4,5,6,7}) << '\n';
  std::cout << maximum_xor<int>({2,4,1,3}) << '\n';
  std::cout << maximum_xor<int>({10,5,7,12,8}) << '\n';
  return 0;
}

