#include <vector>
#include <iostream>
#include <algorithm>
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

std::vector<int> toBinary( int n ) {
  std::vector<int> binaryDigits ;
  while ( n != 0 ) {
      binaryDigits.push_back( n % 2 ) ;
      n /= 2 ;
  }
  return binaryDigits ;
}

bool isPernicious( int n ) {
  std::vector<int> binaryDigits { toBinary( n ) } ;
  return isPrime( std::count( binaryDigits.begin( ) , binaryDigits.end( ) ,
        1 )) ;
}

int main( ) {
  std::vector<int> perniciousNumbers ;
  int current = 0 ;
  while ( perniciousNumbers.size( ) != 10 ) {
      current++ ;
      if ( isPernicious( current ) )
    perniciousNumbers.push_back( current ) ;
  }
  for ( int i : perniciousNumbers )
      std::cout << i << ' ' ;
  std::cout << std::endl ;
  return 0 ;
}
