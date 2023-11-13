#include<iostream>
#include<vector>

template<typename T>
size_t arithmetic_triplets(const std::vector<T> &vec,T diff)
{
  size_t count{};
  for(size_t i = 0; i < vec.size(); ++i)
  {
    for(size_t j = i+1; j < vec.size(); ++j)
    {
      for(size_t k = j+1; k < vec.size(); ++k)
      {
	if((vec.at(j) - vec.at(i) == diff) &&
	   (vec.at(k) - vec.at(j) == diff))
	  count++;
      }
    }
  }
  return count;
}

int main(void)
{
  std::vector<int> vec1{0,1,4,6,7,10},vec2{4,5,6,7,8,9};
  std::cout << arithmetic_triplets<int>(vec1,3) << '\n'
	    << arithmetic_triplets<int>(vec2,2) << '\n';
  return 0;
}

