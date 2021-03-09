#include <iostream>
#include <cmath>
#include <cstdlib>
#include <string>
#include <algorithm>

bool isPerfectSquare( int n ) {
  return sqrt( n ) == floor( sqrt( n ) ) ;
}

bool isRare( int n ) {
  std::string numstring( std::to_string( n ) ) ;
  std::reverse( numstring.begin( ) , numstring.end( ) ) ;
  int reversed = std::stoi( numstring ) ;
  return ( isPerfectSquare( n + reversed ) && isPerfectSquare( n -
        reversed )) ;
}

int main( int argc, char * argv[] ) {
  int num = std::atoi( argv[1] ) ;
  int lowerend = static_cast<int>( std::pow( static_cast<double>( 10 ) ,
        static_cast<double>( num - 1 ) )) ;
  int upperend = static_cast<int>( std::pow( static_cast<double>( 10 ) ,
        static_cast<double>( num ) )) ;
  for ( int i = lowerend ; i < upperend ; i++ ) {
      if ( isRare( i ) ) {
    std::cout << i << std::endl ;
      }
  }
  return 0 ;
}
