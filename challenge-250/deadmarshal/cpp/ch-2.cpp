#include<iostream>
#include<vector>

bool is_numeric(const std::string &str)
{
  for(const auto& c : str) if(!isdigit(c)) return false;
  return true;
}

template<typename T>
size_t alphanumeric_string_value(const std::vector<T> &vec)
{
  size_t max{};
  for(auto & e : vec)
  {
    size_t n = is_numeric(e) ? std::stoi(e) : e.size();
    if(n > max) max = n;
  }
  return max;
}

int main()
{
  std::vector<std::string> vec1{"perl","2","000","python","r4ku"},
    vec2{"001","1","000","0001"};
  std::cout << alphanumeric_string_value<std::string>(vec1) << '\n'
	    << alphanumeric_string_value<std::string>(vec2) << '\n';
  return 0;
}

