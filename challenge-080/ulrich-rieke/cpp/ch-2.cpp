#include <vector>
#include <iostream>

std::vector<int> enterArray ( int limit ) {
  std::vector<int> numbers ;
  int num ;
  while ( numbers.size( ) < limit ) {
      std::cin >> num ;
      numbers.push_back( num ) ;
  }
  return numbers ;
}

int main( ) {
  int limit ;
  std::cout << "How many numbers do you want to enter ?\n" ;
  std::cin >> limit  ;
  std::cout << "Enter " << limit << " numbers!\n" ;
  std::vector<int> numbers = enterArray( limit ) ;
  int len = numbers.size( ) ;
  int candies = len ;
  for ( int i = 0 ; i < len - 1 ; i++ ) {
      if ( numbers[ i ] != numbers[ i + 1 ] ) {
    candies++ ;
      }
  }
  std::cout << std::endl ;
  std::cout << candies << std::endl ;
  return 0 ;
}
