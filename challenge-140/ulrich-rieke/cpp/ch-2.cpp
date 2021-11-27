#include <vector>
#include <iostream>
#include <algorithm>

int main( ) {
  std::cout << "Enter an positive integer!\n" ;
  int i ;
  std::cin >> i ;
  std::cout << "\nanother positive integer!\n" ;
  int j ;
  std::cin >> j ;
  std::cout << "\nanother positive integer!\n" ;
  int k ;
  std::cin >> k ;
  std::vector<int> allNumbers ;
  for ( int n = 1 ; n < j + 1 ; n++ )
      allNumbers.push_back( n ) ;
  for ( int mult = 2 ; mult < i + 1 ; mult++ ) {
      for ( int n = 1 ; n < j + 1 ; n++ ) {
    allNumbers.push_back( n * mult ) ;
      }
  }
  std::sort( allNumbers.begin( ) , allNumbers.end( ) ) ;
  std::cout << allNumbers[ k - 1 ] << std::endl ;
  return 0 ;
}
