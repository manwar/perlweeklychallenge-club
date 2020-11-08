#include <iostream>
#include <cmath>
#include <cstdlib>

int main( int argc, char * argv[] ) {
  int n = std::atoi( argv[ 1 ] ) ;
  int powerlimit = 0 ;
  //the limit is the square root of n. We cycle through all numbers from 2 to
  //the square root and finish cycling as soon as we find 2 integers that
  //form n ; the functions from cmath require some type juggling
  int lowerlimit = static_cast<int>( sqrt( static_cast<double>( n ) ) ) ;
  for ( int i = 2 ; i < lowerlimit + 1 ; i++ ) {
      double expo = 2.0 ;
      int power = static_cast<int>(std::pow( static_cast<double>( i ) , expo )) ;
      while ( power < n ) {
    expo += 1.0 ;
        power = static_cast<int>(std::pow( static_cast<double>( i ) , expo )) ;
      }
      if ( power == n ) {
    powerlimit = 1 ;
    break ;
      }
  }
  std::cout << powerlimit << std::endl ;
  return 0 ;
}
