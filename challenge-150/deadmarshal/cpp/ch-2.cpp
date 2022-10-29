#include<iostream>
#include<vector>
#include<algorithm>

std::vector<int> prime_factors(int n)
{
  int c = 2;
  std::vector<int> v{};
  while(n > 1)
  {
    if(n % c == 0)
    {
      v.push_back(c);
      n /= c;
    }
    else c++;
  } 
  return v;
}

std::vector<int> square_free_integers()
{
  std::vector<int> v{};
  int i = 1;
  do{
    std::vector<int> factors = prime_factors(i);
    std::sort(factors.begin(), factors.end());
    const bool hasDups = std::adjacent_find(factors.begin(),
					    factors.end())
      != factors.end();
    if(!hasDups)
      v.push_back(i);
    i++;
  }while(i <= 500);
  return v;
}

int main()
{
  std::vector<int> v = square_free_integers();
  for(const auto& e : v)
    std::cout << e << " ";
  std::cout << "\n"; 
  return 0;
}
