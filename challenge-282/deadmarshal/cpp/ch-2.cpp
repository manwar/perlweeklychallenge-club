#include<iostream>
#include<string>
#include<cctype>

std::size_t changing_keys(const std::string &str)
{
  std::size_t count{};
  for(std::size_t i = 1; i < str.size(); ++i)
    if(tolower(str[i]) != tolower(str[i-1])) count++;
  return count;
}

int main()
{
  std::cout << changing_keys("pPeERrLl") << '\n'
	    << changing_keys("rRr") << '\n'
	    << changing_keys("GoO") << '\n';
  return 0;
}

