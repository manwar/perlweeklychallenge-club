#include<iostream>
#include<vector>
#include<algorithm>

template<typename T>
int max_gap(std::vector<T> &vec)
{
  if(vec.size() < 2) return 0;
  std::sort(vec.begin(),vec.end());
  size_t i{};
  int max{},count{},temp{};
  while(i < vec.size())
  {
    temp = abs(vec[i] - vec[i+1]);
    if(temp > max) max = temp;
    i += 2;
  }
  for(i = 0; i < vec.size()-1; ++i)
    if(abs(vec[i] - vec[i+1]) == max) count++;
  return count;
}

int main()
{
  std::vector<int> vec1{2,5,8,1},vec2{3};
  std::cout << max_gap<int>(vec1) << '\n';
  std::cout << max_gap<int>(vec2) << '\n';
  return 0;
}

