#include <iostream>
#include <string>
#include <cstdlib>
#include <algorithm>

bool isPalindrome( int d ) {
  std::string numberstring( std::to_string( d ) ) ;
  std::string reversed { numberstring } ;
  std::reverse( reversed.begin( ) , reversed.end( ) ) ;
  return reversed == numberstring ;
}

int main( int argc, char * argv[] ) {
  int n = std::atoi( argv[ 1 ] ) ;
  int output = 1 ;
  while ( n < 10 || n > 1000 ) {
      std::cout << "number should be between 10 and 1000!" << std::endl ;
      std::cin >> n ;
  }
  int iterations = 0 ;
  int number = n ;
  while ( iterations < 500 ) {
      std::string numberstring( std::to_string( n ) ) ;
      std::reverse( numberstring.begin( ) , numberstring.end( ) ) ;
      number += std::stoi( numberstring ) ;
      if ( isPalindrome( number ) ) {
    output = 0 ;
    break ;
      }
      if ( number > 10000000 ) {
    output = 1 ;
    break ;
      }
      iterations++ ;
  }
  if ( iterations >= 500 )
      output = 1 ;
  std::cout << output << std::endl ;
  return 0 ;
}
