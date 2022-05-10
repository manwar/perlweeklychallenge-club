#include <string>
#include <iostream>
#include <vector>
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

bool isPalindrome( int n ) {
  std::string numberstring( std::to_string( n ) ) ;
  std::string compared { numberstring } ;
  std::reverse( compared.begin( ) , compared.end( ) ) ;
  return numberstring ==  compared  ;
}

int main( ) {
  std::vector<int> solution ;
  for ( int i = 1 ; i < 1000 ; i++ ) {
      if ( isPrime( i ) && isPalindrome( i ) )
    solution.push_back( i ) ;
  }
  for ( int i : solution )
      std::cout << i << ' ' ;
  std::cout << std::endl ;
  return 0 ;
}
