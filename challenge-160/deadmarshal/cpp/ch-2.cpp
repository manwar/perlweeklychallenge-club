#include<iostream>
#include<vector>
#include<numeric>

int equilibrium_index(const std::vector<int>& vec)
{
  int left = 0, right = std::accumulate(vec.begin(), vec.end(), 0);
  int ret = -1;
  for(std::size_t i = 0; i < vec.size(); ++i)
  {
    right -= vec[i];
    if(left == right)
    {
      ret = i;
      break;
    }
    left += vec[i];
  }
  return ret;
}

int main()
{
  std::vector<int> vec{1,3,5,7,9};
  std::cout << equilibrium_index(vec) << '\n';

  vec = {1,2,3,4,5};
  std::cout << equilibrium_index(vec) << '\n';

  vec = {2,4,2};
  std::cout << equilibrium_index(vec) << '\n';
  
  return 0;
}
