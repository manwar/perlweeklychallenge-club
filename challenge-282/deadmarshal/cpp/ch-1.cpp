#include<iostream>
#include<string>

template<typename T>
std::string good_integer(T n)
{
  std::string str = std::to_string(n);
  char prev = '\0';
  std::size_t seen{};
  for(std::size_t i = 0; i < str.size(); ++i){
    if(prev == str[i]) seen++;
    else if(seen == 3) return std::string(3,prev);
    else {
      prev = str[i];
      seen = 1;
    }
  }
  return "-1";
}

int main()
{
  std::cout << good_integer<int>(12344456) << '\n'
	    << good_integer<int>(1233334) << '\n'
	    << good_integer<int>(10020003) << '\n';
  return 0;
}

