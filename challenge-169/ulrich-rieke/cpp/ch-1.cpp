#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

std::vector<int> primeDecompose( int n ) {
  std::vector<int> primeFactors ;
  int current = 2 ;
  while ( n != 1 ) {
      if ( n % current == 0 ) {
        primeFactors.push_back( current ) ;
        n /= current ;
      }
      else {
        current++ ;
      }
  }
  return primeFactors ;
}

bool isBrilliant( int n ) {
  std::vector<int> primeFactors( primeDecompose( n ) ) ;
  if ( primeFactors.size( ) == 2 ) {
      std::vector<std::string> primeNumbers( 2 ) ;
      std::transform( primeFactors.begin( ) , primeFactors.end( ) ,
        primeNumbers.begin( ) , []( int i ){ return std::to_string( i ) ;} ) ;
      return primeNumbers.begin()->length( ) == primeNumbers.back().length( ) ;
  }
  else {
      return false ;
  }
}

int main( ) {
  std::vector<int> brilliantNumbers ;
  int current = 2 ;
  while ( brilliantNumbers.size( ) != 20 ) {
      if ( isBrilliant( current ) )
    brilliantNumbers.push_back( current ) ;
      current++ ;
  }
  for ( int i : brilliantNumbers )
      std::cout << i << " " ;
  std::cout << std::endl ;
  return 0 ;
}
