#include <iostream>
#include <cmath>
#include <cstdlib>

int main( int argc, char * argv[ ] ) {
  if ( argc != 3 ) {
      std::cerr << "Error! usage <challenge105> <inversed root> <number>!\n" ;
      return 1 ;
  }
  int n = std::atoi( argv[ 1 ] ) ;
  int k = std::atoi( argv[ 2 ] ) ;
  double d = std::pow( static_cast<double>( k ) ,
    (static_cast<double>( 1 ) / static_cast<double>( n ) ) ) ;
  std::cout << d << std::endl ;
  return 0 ;
}
