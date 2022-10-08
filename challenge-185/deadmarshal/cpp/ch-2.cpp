#include<iostream>
#include<string>
#include<vector>
#include<cctype>

void mask_code(std::vector<std::string>& vec)
{
  int count{};
  for(auto& str : vec)
  {
    for(auto& c : str)
    {
      if(isalnum(c))
      {
	c = 'x';
	count++;
      }
      if(count == 4) break;
    }
    count = 0;
  }
}

int main()
{
  std::vector<std::string>
    list{"ab-cde-123", "123.abc.420", "3abc-0010.xy"};
  std::vector<std::string>
    list2{"1234567.a", "a-1234-bc", "a.b.c.d.e.f"};
  mask_code(list);
  mask_code(list2);
  for(const auto& str : list)
    std::cout << str << ' ';
  std::cout << '\n';
  for(const auto& str : list2)
    std::cout << str << ' ';  
  return 0;
}
