#include <iostream>
#include <vector>
#include <cmath>

bool isPrime( int n ) {
  if ( n == 1 )
      return false ;
  if ( n == 2 )
      return true ;
  int root = static_cast<int>( floor( sqrt( static_cast<double>( n ) ))) ;
  for ( int i = 2 ; i < root + 1 ; i++ )
      if ( n % i == 0 )
        return false ;
  return true ;
}

int main( ) {
  std::vector<int> cubanPrimes ;
  int current = 0 ;
  do {
      current++ ;
      int sum = 3 * current * current + 3 * current + 1 ;
      if ( isPrime( sum ) )
    cubanPrimes.push_back( sum ) ;
  } while ( cubanPrimes.back( ) < 1000 ) ;
  int len = cubanPrimes.size( ) ;
  for ( int i = 0 ; i < len - 1 ; i++ )
      std::cout << cubanPrimes[ i ] << " " ;
  std::cout << std::endl ;
  return 0 ;
}
