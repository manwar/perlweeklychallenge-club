#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

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
  std::cout << "Please enter a line of letters and digits, separated by a blank!\n" ;
  std::string line ;
  std::getline( std::cin, line ) ;
  std::vector<std::string> firstLine( split( line , " " )) ;
  std::cout << "Enter another line of letters and digits!\n" ;
  std::getline( std::cin, line ) ;
  std::vector<std::string> secondLine( split( line, " " )) ;
  int smaller = std::min( firstLine.size( ) , secondLine.size( ) ) ;
  std::string output ;
  for ( int i = 0 ; i < smaller ; i++ ) {
      output.append( firstLine[ i ] ) ;
      output.append( "," ) ;
      output.append( secondLine[ i ] ) ;
      output.append( ",") ;
  }
  std::cout << output.substr( 0 , output.length( ) - 1 ) << std::endl ;
  return 0 ;
}
