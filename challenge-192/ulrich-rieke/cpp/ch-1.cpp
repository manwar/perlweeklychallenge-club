#include <iostream>
#include <cstdlib>
#include <algorithm>
#include <vector>

int main( int argc , char * argv[] ) {
  if ( argc != 2 ) {
      std::cerr << "usage : <programname> <positive integer>\n" ;
      return 1 ;
  }
  int number = std::atoi( argv[ 1 ] ) ;
  std::vector<int> binaryDigits ;
  while ( number != 0 ) {
      binaryDigits.push_back( number % 2 ) ;
      number /= 2 ;
  }
  std::reverse( binaryDigits.begin( ) , binaryDigits.end( ) ) ;
  for ( int i = 0 ; i < binaryDigits.size( ) ; i++ ) {
      if ( binaryDigits[ i ] == 0 )
    binaryDigits[ i ] = 1 ;
      else
    binaryDigits[ i ] = 0 ;
  }
  std::reverse( binaryDigits.begin( ) , binaryDigits.end( ) ) ;
  int sum = 0 ;
  int multiplier = 1 ;
  for ( int n : binaryDigits ) {
      sum += n * multiplier ;
      multiplier *= 2 ;
  }
  std::cout << sum << std::endl ;
  return 0 ;
}
