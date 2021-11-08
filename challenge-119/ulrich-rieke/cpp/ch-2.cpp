#include <string>
#include <regex>
#include <iostream>
#include <cstdlib>
#include <list>
#include <algorithm>

bool isValid( int n ) {
  std::string regexExp { "11" } ;
  std::regex myReg { regexExp } ;
  std::string numberstring( std::to_string( n ) ) ;
  if ( std::regex_search( numberstring , myReg ) )
      return false ;
  int ones = std::count( numberstring.begin( ) , numberstring.end( ) , '1' ) ;
  int twos = std::count( numberstring.begin( ) , numberstring.end( ) , '2' ) ;
  int threes = std::count( numberstring.begin( ) , numberstring.end( ) , '3' ) ;
  if ( ones + twos + threes == numberstring.length( ) )
      return true ;
  return false ;
}

int main( int argc, char * argv[] ) {
  int n = std::atoi( argv[ 1 ] ) ;
  std::list<int> numbers ;
  int current = 1 ;
  numbers.push_back( 1 ) ;
  while ( numbers.size( ) < n ) {
      current++ ;
      if ( isValid( current ) )
    numbers.push_back( current ) ;
  }
  std::cout << numbers.back( ) << std::endl ;
  return 0 ;
}
