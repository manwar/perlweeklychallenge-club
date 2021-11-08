#include <string>
#include <iostream>
#include <cstdlib>
#include <algorithm>

std::string toBinaryString( int n ) {
  std::string binaryString ;
  while ( n != 0 ) {
      int i = n % 2 ;
      binaryString.append( std::to_string( i )) ;
      n /= 2 ;
  }
  reverse( binaryString.begin( ) , binaryString.end( ) ) ;
  return binaryString ;
}

int main( int argc , char * argv[] ) {
  int n = std::atoi( argv[ 1 ] ) ;
  std::string numberstring( toBinaryString( n ) ) ;
  int ones = std::count( numberstring.begin( ) , numberstring.end( ) , '1' ) ;
  numberstring = toBinaryString( ++n ) ;
  while ( std::count( numberstring.begin( ) , numberstring.end( ) , '1' ) != ones ) {
      n++ ;
      numberstring = toBinaryString( n ) ;
  }
  std::cout << n << std::endl ;
  return 0 ;
}
