#include<iostream>
#include<vector>

int divisible_pairs(const std::vector<int>& vec, int k)
{
  int count{};
  for(int i{}; i < vec.size(); ++i)
    for(int j = i+1; j < vec.size(); ++j)
      if((vec[i] + vec[j]) % k == 0) count++;
  return count;
}

int main()
{
  std::cout << divisible_pairs({4,5,1,6}, 2) << '\n';
  std::cout << divisible_pairs({1,2,3,4}, 2) << '\n';
  std::cout << divisible_pairs({1,3,4,5}, 3) << '\n';
  std::cout << divisible_pairs({5,1,2,3}, 4) << '\n';
  std::cout << divisible_pairs({7,2,4,2}, 4) << '\n';
  return 0;
}
