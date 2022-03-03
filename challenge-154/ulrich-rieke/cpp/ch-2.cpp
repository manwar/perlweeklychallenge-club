#include <vector>
#include <set>
#include <iostream>
#include <algorithm>
#include <cmath>

bool isPrime( long n ) {
  if ( n == 1 )
      return false ;
  if ( n == 2 )
      return true ;
  long root = static_cast<long>( floor( sqrt( static_cast<double>( n ) ))) ;
  for ( long i = 2 ; i < root + 1 ; i++ )
      if ( n % i == 0 )
    return false ;
  return true ;
}

int main( ) {
  std::vector<long> padovans { 1 , 1 , 1 } ;
  std::vector<long> padovanPrimes ;
  while ( padovanPrimes.size( ) != 10 ) {
      padovans.push_back( *(padovans.begin()) + *(padovans.begin( ) + 1 ) ) ;
      long last = padovans.back( ) ;
      if ( isPrime( last ) ) {
    if ( std::find( padovanPrimes.begin( ) , padovanPrimes.end( ) , last )
          == padovanPrimes.end( ) ) {
        padovanPrimes.push_back( last ) ;
    }
      }
      padovans.erase( padovans.begin( ) ) ;
  }
  for ( long i : padovanPrimes )
      std::cout << i << " " ;
  std::cout << std::endl ;
  return 0 ;
}
