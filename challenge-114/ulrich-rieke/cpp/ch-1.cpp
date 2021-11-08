#include <string>
#include <iostream>
#include <algorithm>
#include <cstdlib>

bool isPalindromeNumber( int n ) {
  std::string numberstring( std::to_string( n ) ) ;
  std::string comparison( numberstring ) ;
  std::reverse( comparison.begin( ) , comparison.end( ) ) ;
  return numberstring == comparison ;
}

int main( int argc , char * argv[] ) {
  int n = std::atoi( argv[ 1 ] ) ;
  n++ ;
  while ( ! isPalindromeNumber( n ) )
      n++ ;
  std::cout << n << std::endl ;
  return 0 ;
}
