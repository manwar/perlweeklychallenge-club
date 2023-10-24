#include<iostream>
#include<vector>
#include<string>
#include<cctype>

bool acronym(const std::vector<std::string> &vec,
	     const std::string check)
{
  std::string ret{};
  for(const auto str : vec) ret += tolower(str[0]);
  return ret == check;
}

int main()
{
  std::vector<std::string> vec1{"Perl","Python","Pascal"};
  std::vector<std::string> vec2{"Perl","Raku"};
  std::vector<std::string> vec3{"Oracle","Awk","C"};
  std::cout << acronym(vec1,"ppp") << '\n'
	    << acronym(vec2,"rp") << '\n'
	    << acronym(vec3,"oac") << '\n';
  return 0;
}

