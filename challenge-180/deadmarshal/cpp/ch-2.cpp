#include<iostream>
#include<vector>
#include<algorithm>

int main()
{
  std::vector<int> n{1,4,2,3,5};
  std::vector<int> n2{9,0,6,2,3,8,5};
  int i = 3, i2 = 4;
  auto removed = std::remove_if(n.begin(),
				n.end(),
				[&i](int num){return num <= i;});
  n.erase(removed, n.end());
  for(const int& item : n)
    std::cout << item << ' ';
  std::cout << '\n';
  
  auto removed2 = std::remove_if(n2.begin(),
				n2.end(),
				[&i2](int num){return num <= i2;});
  n2.erase(removed2, n2.end());
  for(const int& item : n2)
    std::cout << item << ' ';
  
  return 0;
}
