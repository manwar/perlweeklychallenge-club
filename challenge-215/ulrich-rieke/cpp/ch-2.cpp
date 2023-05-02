#include <iostream>
#include <string>
#include <algorithm>
#include <vector>

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
  std::cout << "Please enter a line of 1's and 0's, separated by blanks!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> numberstrings( split( line, " " ) ) ;
  std::vector<int> numbers ;
  for ( auto s : numberstrings )
      numbers.push_back( std::stoi( s ) ) ;
  std::cout << "How many 0's should be replaced ?\n" ;
  int num ;
  std::cin >> num ;
  int necessary = 0 ;
  if ( num == 1 )
      necessary = 3 ;
  if ( num > 1 )
      necessary = 3 + num ;
  int len = numbers.size( ) ;
  if ( len < necessary || len == necessary )
      std::cout << 0 << std::endl ;
  else {
      std::vector<bool> results ;
      for ( int start = 0 ; start < len - necessary + 1 ; start++ ) {
    if ( std::all_of( numbers.begin( ) + start , numbers.begin( ) + start
          + necessary , []( int n ) { return n == 0 ; } ) ) {
        results.push_back( true ) ;
    }
    else
        results.push_back( false ) ;
      }
      if ( std::any_of( results.begin( ) , results.end( ) , []( auto b ) {
          return b == true ; })) {
    std::cout << 1 << std::endl ;
      }
      else {
    std::cout << 0 << std::endl ;
      }
  }
  return 0 ;
}
