#include<iostream>
#include<vector>
#include<cctype>

std::size_t max_words(const std::vector<std::string> &vec)
{
  size_t count{},max{};
  for(const auto & s : vec)
  {
    for(const auto &c : s) if(isspace(c)) count++;
    if(max < count) max = count;
    count = 0;
  }
  return max+1;
}

int main(int argc, char **argv)
{
  std::vector<std::string>
    vec{"Perl and Raku belong to the same family.",
	"I love perl.",
	"The Perl and Raku Conference."};
  std::vector<std::string>
    vec2{"The Weekly Challenge.",
	 "Python is the most popular guest language.",
	 "Team PWC has over 300 members."};
  std::cout << max_words(vec) << '\n';
  std::cout << max_words(vec2) << '\n';
  return 0;
}

