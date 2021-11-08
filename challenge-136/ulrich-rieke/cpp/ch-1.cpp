#include <iostream>
#include <cmath>
#include <cstdlib>
#include <numeric>

double log2( int n ) {
  return std::log( static_cast<double>( n )) / std::log( 2 ) ;
}

int main( int argc , char * argv[] ) {
  int m = std::atoi( argv[ 1 ] ) ;
  int n = std::atoi( argv[ 2 ] ) ;
  int commonDiv = std::gcd( m , n ) ;
  double theLog = log2( commonDiv ) ;
  if ( std::floor( theLog ) == theLog )
      std::cout << 1 << std::endl ;
  else
      std::cout << 0 << std::endl ;
  return 0 ;
}
