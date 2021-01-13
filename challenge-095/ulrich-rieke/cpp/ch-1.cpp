#include <algorithm>
#include <string>
#include <iostream>
#include <cstdlib>

bool isPalindrome( int n ) {
  std::string numstring { std::to_string( n ) } ;
  std::string original( numstring ) ;
  std::reverse( numstring.begin( ) , numstring.end( ) ) ;
  return original ==  numstring  ;
}

int main( int argc , char * argv[ ] ) {
  if ( isPalindrome( std::atoi( argv[1] ) ))
      std::cout << 1 ;
  else
      std::cout << 0 ;
  std::cout << std::endl ;
  return 0 ;
}
