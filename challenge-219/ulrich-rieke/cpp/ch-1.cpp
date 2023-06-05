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
  std::cout << "Enter some integers, separated by blanks!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> numberstrings( split( line , " " ) ) ;
  std::vector<int> squares ;
  for ( auto s : numberstrings ) {
      int i = std::stoi( s ) ;
      squares.push_back( i * i) ;
  }
  std::sort( squares.begin( ) , squares.end( ) ) ;
  std::cout << '(' ;
  for ( int i : squares ) {
      std::cout << i ;
      if ( i != squares.back( ) )
    std::cout << ", " ;
      else
    std::cout << ")\n" ;
  }
  return 0 ;
}
