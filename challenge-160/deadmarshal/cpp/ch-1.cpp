#include<iostream>
#include<string>
#include<map>

std::string four_is_magic(int n)
{
  std::map<int, std::string> numbers{};
  std::string ret{};
  std::string arr[] = {"one","two","three","four","five","six","seven",
    "eight","nine"};
  for(int i = 0; i < 9; ++i){
    numbers[i+1] = arr[i];
  }
  size_t len = numbers[n].size();
  do{
    ret += numbers[n] + " is " + numbers[len] + ", ";
    n = len;
    len = numbers[n].size();
  }while(n != 4);
  ret[0] = std::toupper(ret[0]);
  ret += "four is magic.";
  return ret;
}

int main()
{
  std::cout << four_is_magic(5) << '\n';
  std::cout << four_is_magic(7) << '\n';
  std::cout << four_is_magic(6) << '\n';
  
  return 0;
}
