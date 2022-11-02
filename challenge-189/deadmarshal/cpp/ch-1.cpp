#include<iostream>
#include<algorithm>

char greater_character(std::vector<char> vec, char target)
{
  std::sort(vec.begin(), vec.end());
  for(std::size_t i = 0; i < vec.size(); ++i)
  {
    if(vec[i] > target) return vec[i];
  }
  return target;
}

int main()
{
  std::cout << greater_character({'e','m','u','g'}, 'b') << '\n';
  std::cout << greater_character({'d','c','e','f'}, 'a') << '\n';
  std::cout << greater_character({'j','a','r'}, 'o') << '\n';
  std::cout << greater_character({'d','c','a','f'}, 'a') << '\n';
  std::cout << greater_character({'t','g','a','l'}, 'v') << '\n'; 
  return 0;
}

