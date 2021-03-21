#include <vector>
#include <iostream>

int main( ) {
  std::vector<int> fusc ;
  fusc.push_back( 0 ) ;
  fusc.push_back( 1 ) ;
  for ( int n = 2 ; n < 50 ; n++ ) {
      if ( n % 2 == 0 ) {
    fusc.push_back( fusc[ n / 2 ] ) ;
      }
      else {
    int half = n / 2 ;
    fusc.push_back( fusc[ half ] + fusc[ half + 1 ] ) ;
      }
  }
  for ( int i : fusc ) {
      std::cout << i << " " ;
  }
  std::cout << '\n' ;
  return 0 ;
}
