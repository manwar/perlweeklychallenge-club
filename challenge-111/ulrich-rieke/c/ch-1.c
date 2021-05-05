#include <iostream>
#include <vector>
#include <algorithm>

int main( ) {
  std::vector<int> numbers ;
  std::cout << "Enter numbers, that should be sorted, 0 to end\n" ;
  int number ;
  std::cin >> number ;
  while ( number != 0 ) {
      numbers.push_back( number ) ;
      std::cin >> number ;
  }
  std::cout << "Which number do you want to search for?\n" ;
  std::cin >> number ;
  if ( ! std::is_sorted( numbers.begin( ), numbers.end( ) ) )
      std::sort( numbers.begin( ) , numbers.end( ) ) ;
  if ( std::binary_search( numbers.begin( ) , numbers.end( ) , number ) )
      std::cout << "1 as it exists in the matrix\n" ;
  else
      std::cout << "0 since it is missing in the matrix\n" ;
  return 0 ;
}
