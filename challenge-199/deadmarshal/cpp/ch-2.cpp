#include<iostream>
#include<vector>

template<typename T>
int good_triplets(const std::vector<T> &vec, int x, int y, int z)
{
  int count{};
  for(size_t i = 0; i < vec.size(); ++i)
    for(size_t j = 0; j < vec.size(); ++j)
      for(size_t k = 0; k < vec.size(); ++k)
	if((abs(vec[i] - vec[j]) <= x) &&
	   (abs(vec[j] - vec[k]) <= y) &&
	   (abs(vec[i] - vec[k]) <= z) &&
	   (0 <= i) &&
	   (i < j) &&
	   (j < k) &&
	   (k <= vec.size())) count++;
  return count;
}

int main()
{
  std::vector<int> vec1{3,0,1,1,9,7}, vec2{1,1,2,2,3};
  std::cout << good_triplets<int>(vec1,7,2,3) << '\n';
  std::cout << good_triplets<int>(vec2,0,0,1) << '\n';
  return 0;
}

