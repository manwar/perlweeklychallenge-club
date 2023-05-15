#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

std::vector<std::string> split( const std::string & startline ,
      const std::string & sep ) {
  std::vector<std::string> separated ;
  std::string::size_type start { 0 } ;
  std::string::size_type pos ;
  do {
      pos = startline.find_first_of( sep , start ) ;
      separated.push_back( startline.substr(start , pos - start )) ;
      start = pos + 1 ;
  } while ( pos != std::string::npos ) ;
  return separated ;
}

int main( ) {
  std::cout << "Please enter some words, separated by blanks!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> allStrings ( split( line , " " ) ) ;
  std::cout << std::count_if( allStrings.begin( ) , allStrings.end( ) ,
    []( auto s ) { std::string c = s ; std::sort( c.begin( ) ,
        c.end( ) ) ; return c != s ; } ) << std::endl ;
  return 0 ;
}
