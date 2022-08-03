#include<iostream>
#include<vector>
#include<algorithm>

template<typename T>
T reverse_num(T n)
{
  T res{};
  while(n)
  {
    res = (res * 10) + (n % 10);
    n /= 10;
  }
  return res;
}

template<typename T>
std::vector<T> split_num(T n)
{
  std::vector<T> vec{};
  while(n){
    vec.push_back(n % 10);
    n /= 10;
  }
  return vec;
}

template<typename T>
bool is_reversible_number(T n)
{
  T sum{n + reverse_num<T>(n)};
  std::vector<T> vec = split_num<T>(sum);
  if(std::all_of(vec.cbegin(), vec.cend(),
		 [](int n)
		 {return n % 2 != 0;}))
    return true;
  return false;
}

int main()
{
  int i{1};
  while(i < 100)
  {
    if(is_reversible_number<int>(i))
      std::cout << i << ' ';
    i++;
  }
  return 0;
}
