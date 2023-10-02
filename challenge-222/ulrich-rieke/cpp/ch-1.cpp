#include <iostream>
#include <vector>
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
  std::cout << "Enter some integers, separated by blanks!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> numberstrings( split( line , " " ) ) ;
  std::vector<int> numbers ;
  for ( auto s : numberstrings )
      numbers.push_back( std::stoi( s ) ) ;
  if ( std::is_sorted( numbers.begin( ) , numbers.end( ) ) )
      std::cout << numbers.size( ) << std::endl ;
  else {
      std::vector<int> forSorting( numbers ) ;
      std::sort( forSorting.begin( ) , forSorting.end( ) ) ;
      int posCount = 0 ;
      for ( int i = 0 ; i < numbers.size( ) ; i++ ) {
    if ( numbers[ i ] == forSorting[ i ] )
        posCount++ ;
      }
      std::cout << posCount << std::endl ;
  }
  return 0 ;
}
