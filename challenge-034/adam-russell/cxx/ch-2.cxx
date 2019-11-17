/**
* Write a program that demonstrates a dispatch table.
**/
#include <map>
#include <string> 
#include <iostream>
#include <functional>

int main(){
  std::map< const std::string , std::function<void(void)> > dispTable{
      {"hello",[](){ std::cout << "Hello!" << std::endl; } },
      {"goodbye",[](){ std::cout << "Goodbye!" << std::endl; } } 
  };
  dispTable["hello"]();
  dispTable["goodbye"]();
};
