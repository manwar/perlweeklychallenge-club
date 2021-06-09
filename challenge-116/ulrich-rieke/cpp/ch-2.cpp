#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>
#include <cstdlib>
#include <cmath>

int main( int argc , char * argv[] ) {
  if ( argc != 2 ) {
      std::cerr << "Usage: challenge116_2 <number>!\n" ;
      return 1 ;
  }
  int n = std::atoi( argv[ 1 ] ) ;
  if ( n < 10 ) {
      std::cerr << "Number must be greater than 9!\n" ;
      return 2 ;
  }
  std::vector<int> digits ;
  while ( n != 0 ) {
      digits.push_back( n % 10 ) ;
      n /= 10 ;
  }
  std::transform( digits.begin( ) , digits.end( ) , digits.begin( ) ,
    []( int a ) { return a * a ; } ) ;
  int squaresum = std::accumulate( digits.begin( ) , digits.end( ) , 0 ) ;
  double theRoot = std::sqrt( static_cast<double>( squaresum ) ) ;
  if ( std::floor( theRoot ) == theRoot )
      std::cout << 1 << std::endl ;
  else
      std::cout << 0 << std::endl ;
  return 0 ;
}
