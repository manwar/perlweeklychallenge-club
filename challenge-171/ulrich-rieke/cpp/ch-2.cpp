#include <iostream>
#include <cmath>

int func1( int n ) {
  return 5 * n ;
}

double func2 ( int m ) {
  return std::sqrt( static_cast<double>( m ) ) ;
}

double compose( int n ) {
  return func2( func1( n ) ) ;
}

int main( ) {
  std::cout << compose( 6 ) << '\n' ;
  return 0 ;
}
