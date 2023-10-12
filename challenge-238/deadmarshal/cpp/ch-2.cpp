#include<iostream>
#include<vector>
#include<algorithm>

template<typename T>
T product(T n)
{
  T prod = 1;
  while(n)
  {
    prod *= n % 10;
    n /= 10;
  }
  return prod;
}

template<typename T>
T helper(T n)
{
  T sum = 0;
  while(n >= 10)
  {
    sum++;
    n = product<T>(n);
  }
  return sum;
}

template<typename T>
void persistence_sort(std::vector<T>& v)
{
  std::sort(v.begin(),v.end(),[](T a, T b){
    T ha = helper<T>(a), hb = helper<T>(b);
    return ha == hb ? a < b : ha < hb;
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
  std::vector<int> vec1{15,99,1,34},vec2{50,25,33,22};
  persistence_sort(vec1);
  persistence_sort(vec2);
  std::cout << vec1 << vec2;
  return 0;
}

