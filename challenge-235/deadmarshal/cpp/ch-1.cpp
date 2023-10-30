#include<iostream>
#include<vector>

template<typename T>
bool remove_one(std::vector<T> &vec)
{
  int c1 = 0, c2 = 0, idx1 = -1, idx2 = -1;
  for(size_t i = 1; i < vec.size(); ++i)
  {
    if(vec[i] <= vec[i-1])
    {
      c1++;
      idx1 = i-1;
    }
  }
  for(size_t i = vec.size()-2; i > 0; --i)
  {
    if(vec[i] >= vec[i+1])
    {
      c2++;
      idx2 = i+1;
    }
  }
  if((c1 == 1) && (c2 == 1) && (idx2 - idx1 + 1 == 2)) return true;
  if((c1 > 1) || (c2 > 1)) return false;
  return true;
}

int main()
{
  std::vector<int> vec1{0,2,9,4,5},vec2{5,1,3,2},vec3{2,2,3};
  std::cout << std::boolalpha << remove_one<int>(vec1) << '\n';
  std::cout << std::boolalpha << remove_one<int>(vec2) << '\n';
  std::cout << std::boolalpha << remove_one<int>(vec3) << '\n';
  return 0;
}

