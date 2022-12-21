#include<iostream>
#include<vector>
#include<algorithm>

std::vector<int> dtov(int n)
{
  std::vector<int> digits{};
  while(n)
  {
    digits.push_back(n % 10);
    n /= 10;
  }
  return digits;
}

int special_integers(int n)
{
  int count{};
  for(int i = 1; i <= n; ++i)
  {
    std::vector<int> digits = dtov(i);
    const bool has_dups =
    std::adjacent_find(digits.begin(), digits.end()) != digits.end();
    if(!has_dups) count++;
  }
  return count;
}

int main()
{
  std::cout << special_integers(15) << '\n';
  std::cout << special_integers(35) << '\n';
  return 0;
}

