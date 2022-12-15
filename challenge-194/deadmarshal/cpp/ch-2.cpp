#include<iostream>
#include<vector>
#include<string>
#include<unordered_map>
#include<algorithm>

bool frequency_equalizer(const std::string &str)
{
  std::unordered_map<char,unsigned> m{};
  std::vector<unsigned> vals{};
  for(const auto &c : str) m[c]++;
  for(const auto& kv : m) vals.push_back(kv.second);
  std::sort(vals.begin(),vals.end(),std::greater<>());
  if((vals[0] == vals[1]+1) && (vals.back() == vals[1])) return true;
  return false;
}

int main()
{
  std::cout << std::boolalpha << frequency_equalizer("abbc")<< '\n';
  std::cout << std::boolalpha << frequency_equalizer("xyzyyxz")<<'\n';
  std::cout << std::boolalpha << frequency_equalizer("xzxz")<< '\n';
  return 0;
}
