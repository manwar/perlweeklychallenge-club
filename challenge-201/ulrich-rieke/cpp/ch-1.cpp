#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <iterator>

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
  std::cout << "Please enter some unique integers, separated by blanks!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<int> numbers ;
  std::vector<std::string> numberstrings( split( line , " " ) ) ;
  std::vector<int> missingNumbers ;
  for ( auto & s : numberstrings )
      numbers.push_back( std::stoi( s ) ) ;
  int len = numbers.size( ) ;
  for ( int i = 0 ; i < len + 1 ; i++ ) {
      if ( std::find( numbers.begin( ) , numbers.end( ) , i ) == numbers.end( ) )
    missingNumbers.push_back( i ) ;
  }
  std::copy( missingNumbers.begin( ) , missingNumbers.end( ) ,
    std::ostream_iterator<int>( std::cout , " " ) ) ;
  std::cout << std::endl ;
  return 0 ;
}
