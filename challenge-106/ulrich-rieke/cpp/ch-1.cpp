#include <iostream>
#include <vector>
#include <algorithm>

int main( ) {
  std::vector<int> numbers ;
  std::cout << "Enter some positive integers (-1 to end)! " ;
  int number ;
  std::cin >> number ;
  while ( number != -1 ) {
      numbers.push_back( number ) ;
      std::cin >> number ;
  }
  if ( numbers.size( ) == 1 ) {
      std::cout << 0 << std::endl ;
      return 0 ;
  }
  else {
      std::sort( numbers.begin( ), numbers.end( ) , []( int a , int b ) { return
        a > b ; } ) ;
      int maxdiff = 0 ;
      int len = numbers.size( ) ;
      for ( int i = 0 ; i < len - 1 ; i++ ) {
    int diff = numbers[ i ] - numbers[ i + 1 ] ;
    if ( diff > maxdiff )
        maxdiff = diff ;
      }
      std::cout << maxdiff << std::endl ;
      return 0 ;
  }
}
