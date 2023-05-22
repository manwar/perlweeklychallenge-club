#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <numeric>

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

long concatenate( const std::vector<std::string> &numbers ) {
  std::string concatenated ;
  for ( int i = 0 ; i < numbers.size( ) ; i++ )
      concatenated.append( numbers[ i ] ) ;
  return std::stol( concatenated ) ;
}

int main( ) {
  std::cout << "Please enter some numbers, separated by blanks!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> numberstrings ( split( line , " " ) ) ;
  std::vector<long> results ;
  results.push_back( concatenate( numberstrings ) ) ;
  std::sort( numberstrings.begin( ) , numberstrings.end( ) ) ;
  while ( std::next_permutation( numberstrings.begin( ) , numberstrings.end( ) )) {
      results.push_back( concatenate( numberstrings )) ;
  }
  std::cout << *std::max_element( results.begin( ) , results.end( ) ) <<
      std::endl ;
  return 0 ;
}
