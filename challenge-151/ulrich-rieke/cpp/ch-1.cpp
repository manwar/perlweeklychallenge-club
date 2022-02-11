#include <string>
#include <iostream>
#include <algorithm>

int main( ) {
  std::cout << "Please enter a tree, hierarchies separated by |!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::cout << std::count( line.begin( ) , line.end( ) , '|' )
      << std::endl ;
  return 0 ;
}
