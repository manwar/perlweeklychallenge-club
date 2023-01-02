#include <iostream>
#include <string>
#include <algorithm>
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
  std::cout << "Please enter some integers, separated by a blank!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> numberstrings( split( line , " " ) ) ;
  if ( numberstrings.size( ) < 2 ) {
      std::cout << 0 << std::endl ;
  }
  else {
      std::vector<int> numbers ;
      for ( auto & s : numberstrings )
    numbers.push_back( std::stoi( s ) ) ;
      std::sort( numbers.begin( ) , numbers.end( )) ;
      std::vector<int> differences( numbers.size( ) ) ;
      std::adjacent_difference( numbers.begin( ) , numbers.end( ) ,
        differences.begin() ) ;
      int maxdiff = *std::max_element( differences.begin( ) , differences.end( ) ) ;
      std::cout << std::count( differences.begin( ) , differences.end( ) ,
        maxdiff ) << std::endl ;
  }
  return 0 ;
}
