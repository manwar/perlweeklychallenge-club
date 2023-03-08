#include <vector>
#include <iostream>
#include <algorithm>
#include <string>

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
  std::cout << "Enter some integers, separated by a blank!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> numberstrings( split( line , " " ) ) ;
  std::vector<int> numbers ;
  for ( auto & st : numberstrings )
      numbers.push_back( std::stoi( st ) ) ;
  std::sort( numbers.begin( ) , numbers.end( ) , []( int a , int b ) {
    return a > b ; } ) ;
  std::vector<int> possible_h ;
  for ( int i = 0 ; i < numbers.size( ) ; i++ ) {
      if ( numbers[ i ] >= ( i + 1 ) )
    possible_h.push_back( i + 1 ) ;
  }
  std::cout << *max_element( possible_h.begin( ) , possible_h.end( ) ) <<
      std::endl ;
  return 0 ;
}
