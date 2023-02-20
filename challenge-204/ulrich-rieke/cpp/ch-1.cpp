#include <string>
#include <algorithm>
#include <iostream>
#include <vector>
#include <numeric>

std::vector<std::string> split( const std::string & startline , const std::string & sep ) {
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
  std::vector<int> numbers ;
  std::string line ;
  std::cout << "Enter some integers, separated by blanks!\n" ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> numberstrings ( split ( line , " " ) ) ;
  for ( auto & s : numberstrings )
      numbers.push_back( std::stoi( s ) ) ;
  std::vector<int> differences ( numbers.size( ) ) ;
  std::adjacent_difference( numbers.begin( ) , numbers.end( ) ,
    differences.begin( ) ) ;
  if ( std::all_of( differences.begin( ) + 1 , differences.end( ) ,
        []( int i ) { return i <= 0 ; } ) ||
    std::all_of( differences.begin( ) + 1 , differences.end( ) ,
        []( int i ) { return i >= 0 ; } ) ) {
      std::cout << 1 << std::endl ;
  }
  else
      std::cout << 0 << std::endl ;
  return 0 ;
}
