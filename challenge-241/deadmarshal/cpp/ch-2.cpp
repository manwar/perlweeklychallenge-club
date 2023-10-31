#include<iostream>
#include<vector>
#include<algorithm>

template<typename T>
size_t count_factors(T n)
{
  size_t count{};
  T c = 2;
  while(n > 1)
  {
    if(n % c == 0)
    {
      n /= c;
      count++;
    }
    else c++;
  }
  return count;
}

template<typename T>
void prime_order(std::vector<T> &vec)
{
  std::sort(vec.begin(),vec.end(),[&](T a, T b){
    size_t fa = count_factors<T>(a);
    size_t fb = count_factors<T>(b);
    return fa == fb ? a < b : fa < fb;
  });
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
  std::vector<int> vec{11,8,27,4};
  prime_order<int>(vec);
  std::cout << vec;
  return 0;
}

