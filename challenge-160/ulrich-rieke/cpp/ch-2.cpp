#include <iostream>
#include <vector>
#include <numeric>

int main( ) {
  std::vector<int> numbers ;
  std::cout << "Enter integers ( at least 3 ) , 0 to end!\n" ;
  int n ;
  while ( numbers.size( ) < 3 ) {
      std::cin >> n ;
      while ( n != 0 ) {
    numbers.push_back( n ) ;
    std::cout << "next number:\n" ;
    std::cin >> n ;
      }
  }
  int len = numbers.size( ) ;
  bool indexFound = false ;
  for ( int i = 0 ; i < len - 1 ; i++ ) {
      if ( std::accumulate( numbers.begin( ) , numbers.begin( ) + i , 0 ) ==
        std::accumulate( numbers.begin( ) + i + 1 , numbers.end( ) , 0) ) {
    std::cout << i << std::endl ;
    indexFound = true ;
    break ;
      }
  }
  if ( !indexFound )
      std::cout << -1 << " as no Equilibrium Index found.\n" ;
  return 0 ;
}
