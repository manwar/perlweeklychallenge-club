#include <iostream>
#include <string>
#include <cmath>
#include <vector>

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

bool isLeftTruncatablePrime( int n ) {
  if ( ! isPrime( n ) )
      return false ;
  std::string numberstring( std::to_string( n ) ) ;
  auto found = numberstring.find( '0' ) ;
  if ( found != std::string::npos )
      return false ;
  int len = static_cast<int>(numberstring.length( ) ) ;
  for ( int i = 0 ; i < len ; i++ ) {
      int num = std::stoi( numberstring.substr( i ) ) ;
      if ( ! isPrime( num ) )
    return false ;
  }
  return true ;
}

int main( ) {
  std::vector<int> leftTruncatables ;
  int current = 0 ;
  while ( leftTruncatables.size( ) < 20 ) {
      current++ ;
      if ( isLeftTruncatablePrime( current ) )
    leftTruncatables.push_back( current ) ;
  }
  for ( int i : leftTruncatables )
      std::cout << i << ' ' ;
  std::cout << std::endl ;
  return 0 ;
}
