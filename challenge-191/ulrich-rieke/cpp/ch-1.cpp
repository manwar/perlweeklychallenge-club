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
  std::cout << "Please enter a number of integers, separated by blanks!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> numberstrings( split( line , " " )) ;
  std::vector<int> numbers ;
  for ( auto & s : numberstrings )
      numbers.push_back( std::stoi( s )) ;
  int maximum = *std::max_element( numbers.begin( ) , numbers.end( )) ;
  if ( std::any_of( numbers.begin( ) , numbers.end( ) , [maximum]( const int n ) {
        return ( n != maximum && maximum < 2 * n ) ; }))
      std::cout << -1 << std::endl ;
  else
      std::cout << 1 << std::endl ;
  return 0 ;
}
