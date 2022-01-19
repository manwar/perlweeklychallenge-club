#include <iostream>
#include <cmath>

bool isPrime( int number ) {
  int stop =  std::sqrt( static_cast<double>( number ) ) ;
  for ( int i = 2 ; i <= stop ; ++i )
      if ( number % i == 0 )
        return false ;
  return true ;
}

int main( ) {
  int current = 1 ;
  int numberOfPrimes = 0 ;
  while ( numberOfPrimes != 10001 ) {
      current++ ;
      if ( isPrime( current ) ) {
    numberOfPrimes++ ;
      }
  }
  std::cout << current << std::endl ;
  return 0 ;
}
