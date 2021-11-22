#include <vector>
#include <iostream>
#include <algorithm>

int main( ) {
  std::vector<int> numbers ;
  std::cout << "Enter integer numbers , 0 to end!" ;
  int number ;
  std::cin >> number ;
  while ( number != 0 ) {
      numbers.push_back( number ) ;
      std::cin >> number ;
  }
  if ( std::is_sorted( numbers.begin( ) , numbers.end( ) ) )
      std::cout << 1 << std::endl ;
  else
      std::cout << 0 << std::endl ;
  return 0 ;
}
