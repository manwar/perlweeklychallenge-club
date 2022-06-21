#include <vector>
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
  std::vector<int> firstPrimes { 1 } ;
  int current = 2 ;
  while ( firstPrimes.size( ) != 10 ) {
      if ( isPrime( current ) )
    firstPrimes.push_back( current ) ;
      current++ ;
  }
  std::vector<int> primorials { 1 } ;
  for ( int i = 1 ; i < 10 ; i++ ) {
      primorials.push_back( primorials.back( ) * firstPrimes[ i ] ) ;
  }
  for ( int n : primorials )
      std::cout << n << ' ' ;
  std::cout << std::endl ;
  return 0 ;
}
