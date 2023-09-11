#include<iostream>
#include<vector>
#include<string>
#include<unordered_map>
#include<set>
#include<algorithm>

std::size_t similar_words(std::vector<std::string> &vec)
{
  std::size_t count{};
  std::unordered_map<std::string,std::size_t> m{};
  for(auto& str : vec)
  {
    std::set<char> chars{};
    str.erase(std::remove_if(str.begin(),str.end(),
			     [&chars](char c){
			       if(chars.count(c)) return true;
			       chars.insert(c);
			       return false;
			     }),
	      str.end());
    std::sort(str.begin(),str.end());
    m[str]++;
  }
  for(const auto& [k,v] : m) count += (v * (v-1)) / 2;
  return count;
}

int main()
{
  std::vector<std::string> vec1{"aba","aabb","abcd","bac","aabc"},
    vec2{"aabb","ab","ba"},vec3{"nba","cba","dba"};
  std::cout << similar_words(vec1) << '\n';
  std::cout << similar_words(vec2) << '\n';
  std::cout << similar_words(vec3) << '\n';
  return 0;
}

