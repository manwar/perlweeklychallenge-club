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
  std::cout << "Enter some matrices with same number of integers, end to end!\n" ;
  std::string line ;
  std::vector<std::vector<int>> matrix ;
  std::vector<int> numberline ;
  std::getline( std::cin , line ) ;
  while ( line != "end" ) {
      std::vector<std::string> numberstrings ( split( line , " " ) ) ;
      for ( auto s : numberstrings )
    numberline.push_back( std::stoi( s ) ) ;
      matrix.push_back( numberline ) ;
      numberline.clear( ) ;
      std::cout << "Enter some numbers, end to end!\n" ;
      std::getline( std::cin , line ) ;
  }
  int len = matrix.size( ) ;
  std::vector<int> diagonals ;
  for ( int i = 0 ; i < len ; i++ ) {
      std::vector<int> subline ( *(matrix.begin( ) + i ) ) ;
      diagonals.push_back( subline[ i ] ) ;
  }
  int comparison = *(diagonals.begin( ) ) ;
  if ( std::all_of( diagonals.begin( ) , diagonals.end( ) , [ comparison ]
      ( int n ) { return n == comparison ; } ) )
      std::cout << "true" ;
  else
      std::cout << "false" ;
  std::cout << std::endl ;
  return 0 ;
}
