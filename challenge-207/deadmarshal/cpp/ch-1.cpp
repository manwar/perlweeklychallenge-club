#include<iostream>
#include<string>
#include<vector>
#include<algorithm>

bool all_match(const std::string &s1, const std::string &s2)
{
  for(auto &c : s1) if(s2.find(c) == std::string::npos) return false;
  return true;
}

void keyboard_word(std::vector<std::string> &vec)
{
  const std::vector<std::string>
    qwerty{"qwertyuiop","asdfghjkl","zxcvbnm"}; 
  for(auto &s : vec)
    std::transform(s.begin(),s.end(),s.begin(),
		   [](unsigned char c){return std::tolower(c);});
  for(const auto &q : qwerty)
    for(const auto &s : vec)
      if(all_match(s,q)) std::cout << s << ' ';
  std::cout << '\n';
}

int main()
{
  std::vector<std::string> vec1{"Hello","Alaska","Dad","Peace"},
    vec2{"OMG","Bye"};
  keyboard_word(vec1);
  keyboard_word(vec2);
  return 0;
}

