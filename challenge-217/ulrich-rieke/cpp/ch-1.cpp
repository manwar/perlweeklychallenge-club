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
  std::cout << "Enter a square matrix of n x n numbers, n >= 2. Enter end to end!\n" ;
  std::string line ;
  std::vector<int> allNumbers ;
  std::getline( std::cin , line ) ;
  while ( line != "end" ) {
      std::vector<std::string> last_line ( split( line , " " ) ) ;
      for ( auto num : last_line ) {
    allNumbers.push_back( std::stoi( num ) ) ;
      }
      std::getline( std::cin , line ) ;
  }
  std::sort( allNumbers.begin( ) , allNumbers.end( ) ) ;
  std::cout << *(allNumbers.begin( ) + 2 ) << std::endl ;
  return 0 ;
}
