#include <vector>
#include <iostream>
#include <string>

int main( ) {
  std::vector<std::string> cities { "Amsterdam" , "Berlin" , "Moscow" } ;
  std::cout << "The vector cities is located at " << &cities << " !\n" ;
  std::cout << "Its memory size is " << sizeof( cities ) << " !\n" ;
  return 0 ;
}
