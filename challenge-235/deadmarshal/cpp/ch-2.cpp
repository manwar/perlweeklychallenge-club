#include<iostream>
#include<vector>

template<typename T>
std::vector<T> duplicate_zeros(std::vector<T> &vec)
{
  std::vector<T> ret{};
  for(const auto& e : vec)
  {
    if(ret.size() == vec.size()) break;
    if(e == 0)
    {
      ret.emplace_back(0);
      ret.emplace_back(0);
    }
    else ret.emplace_back(e);
  }
  return ret;
}

template<typename T>
std::ostream &operator<<(std::ostream &os,
			 const std::vector<T>& vec)
{
  for(const auto &e : vec) os << e << ' ';
  os << "\n";
  return os;
}

int main()
{
  std::vector<int> vec1{1,0,2,3,0,4,5,0},vec2{1,2,3},vec3{0,3,0,4,5};
  std::cout << duplicate_zeros<int>(vec1);
  std::cout << duplicate_zeros<int>(vec2);
  std::cout << duplicate_zeros<int>(vec3);
  return 0;
}

