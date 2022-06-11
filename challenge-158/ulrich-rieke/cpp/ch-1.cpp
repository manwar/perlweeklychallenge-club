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

int sumUp( int n ) {
  int sum = 0 ;
  while ( n != 0 ) {
      sum += n % 10 ;
      n /= 10 ;
  }
  return sum ;
}

bool isAdditivePrime( int n ) {
  return isPrime( n ) && isPrime( sumUp( n ) ) ;
}

int main( ) {
  std::vector<int> additivePrimes ;
  int current = 1 ;
  do {
      current++ ;
      if ( isAdditivePrime( current ) )
    additivePrimes.push_back( current ) ;
  } while ( additivePrimes.back( ) < 100 ) ;
  int len = additivePrimes.size( ) ;
  for ( int i = 0 ; i < len - 1 ; i++ )
      std::cout << additivePrimes[ i ] << " " ;
  std::cout << std::endl ;
  return 0 ;
}
