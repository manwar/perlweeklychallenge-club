#include<iostream>
#include<string>
#include<regex>

unsigned short digital_clock(const std::string &str)
{
  std::regex re{"(.)(.):(.)(.)"};
  std::smatch m;
  if (std::regex_match(str, m, re))
  {
    return m[1] == '?' ? (std::stoi(m.str(2)) < 4 ? 2 : 1)
      : m[2] == '?' ? (std::stoi(m.str(1)) < 2 ? 9 : 3)
      : m[3] == '?' ? 5 : 9;
  }
  return 0;
}

int main()
{
  std::cout << digital_clock("?5:00") << '\n';
  std::cout << digital_clock("?3:00") << '\n';
  std::cout << digital_clock("1?:00") << '\n';
  std::cout << digital_clock("2?:00") << '\n';
  std::cout << digital_clock("12:?5") << '\n';
  std::cout << digital_clock("12:5?") << '\n'; 
  return 0;
}
	 
