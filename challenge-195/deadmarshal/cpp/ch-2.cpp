#include<iostream>
#include<vector>
#include<map>
#include<algorithm>

int most_frequent_even(std::vector<int> vec)
{
  if(std::all_of(vec.begin(),
		 vec.end(),
		 [](int i){return i % 2 != 0;})) return -1;
  vec.erase(std::remove_if(vec.begin(),
			   vec.end(),
			   [](int i){return i % 2 != 0;}),
	    vec.end());
  std::map<int,int,std::greater<int>> map{};
  std::vector<int> keys{},vals{};
  for(const auto& i : vec) map[i]++;
  for(const auto& kv : map)
  {
    keys.push_back(kv.first);
    vals.push_back(kv.second);
  }
  const bool has_dups =
    std::adjacent_find(vals.begin(), vals.end()) != vals.end();
  if(!has_dups) return keys.back();
  return keys.back();
}

int main()
{
  std::cout << most_frequent_even({1,1,2,6,2}) << '\n';
  std::cout << most_frequent_even({1,3,5,7}) << '\n';
  std::cout << most_frequent_even({6,4,4,6,1}) << '\n';
  return 0;
}

