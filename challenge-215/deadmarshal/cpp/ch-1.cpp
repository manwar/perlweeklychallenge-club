#include<iostream>
#include<vector>
#include<string>

bool is_alphabetical_order(const std::string &str)
{
  for(size_t i = 1; i < str.size(); ++i)
    if(str[i] < str[i-1]) return false;
  return true;
}

size_t odd_one_out(const std::vector<std::string> &vec)
{
  size_t count{};
  for(size_t i = 0; i < vec.size(); ++i)
    if(!is_alphabetical_order(vec[i])) count++;
  return count;
}

int main()
{
  std::vector<std::string> vec1{"abc","xyz","tsu"},
    vec2{"rat","cab","dad"},
    vec3{"x","y","z"};
  std::cout << odd_one_out(vec1) << '\n';
  std::cout << odd_one_out(vec2) << '\n';
  std::cout << odd_one_out(vec3) << '\n';
  return 0;
}

