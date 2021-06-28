#include <cstdlib>
#include <iostream>
#include <string>
#include <algorithm>

int main( int argc, char * argv[] ) {
  int n = std::atoi( argv[ 1 ] ) ;
  std::string binarystring ;
  while ( n != 0 ) {
      binarystring.append( std::to_string( n % 2 ) ) ;
      n /= 2 ;
  }
  std::reverse( binarystring.begin( ) , binarystring.end( ) ) ;
  std::string reversed( binarystring ) ;
  std::reverse( reversed.begin( ) , reversed.end( ) ) ;
  if ( reversed == binarystring )
      std::cout << 1 << std::endl ;
  else
      std::cout << 0 << std::endl ;
  return 0 ;
}
