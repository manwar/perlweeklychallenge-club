#include <vector>
#include <string>
#include <algorithm>
#include <iostream>

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
  std::cout << "Please enter some integers, separated by blanks!\n" ;
  std::cout << "There should be a maximum of one number missing and one duplicate!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> numberstrings ( split( line , " " ) ) ;
  std::vector<int> numbers ;
  for ( auto & s : numberstrings )
      numbers.push_back( std::stoi( s ) ) ;
  std::sort( numbers.begin( ) , numbers.end( ) ) ;
  int len = numbers.size( ) ;
  std::vector<int> found ;
  for ( int i = 0 ; i < len - 1 ; i++ ) {
      if ( numbers[ i + 1 ] == numbers[ i ] ) { //duplicate
    found.push_back( numbers[ i ] ) ;
    if ( i == len - 2 ) { //duplicate also means missing at the end
        found.push_back( numbers[ i ] + 1 ) ;
    }
      }
      if ( numbers[ i + 1 ] - numbers[ i ] > 1 ) { //missing
    found.push_back( numbers[ i ] + 1 ) ;
      }
  }
  if ( found.size( ) > 0 ) {
      std::cout << '(' ;
      for ( int i : found ) {
    std::cout << i ;
    if ( i != found.back( ) )
        std::cout << ',' ;
      }
      std::cout << ")\n" ;
  }
  else {
      std::cout << -1 << std::endl ;
  }
  return 0 ;
}
