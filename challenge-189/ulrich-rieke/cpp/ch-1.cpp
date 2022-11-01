#include <iostream>
#include <string>
#include <vector>
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
  std::cout << "Please enter a number of characters, separated by a blank!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> characters = split( line , " " ) ;
  std::cout << "Please enter a target character!\n" ;
  char c ;
  std::cin >> c ;
  std::sort( characters.begin( ) , characters.end( ) ) ;
  auto it = characters.begin( ) ;
  char letter = *(it->begin( )) ;
  while ( letter <= c ) {
      it++ ;
      letter = *(it->begin( )) ;
  }
  std::cout << letter << std::endl ;
  return 0 ;
}
