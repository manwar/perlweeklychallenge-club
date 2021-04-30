#include <iostream>
#include <string>
#include <regex>
#include <fstream>
#include <vector>

int main( int argc, char * argv[] ) {
  if ( argc != 2 ) {
      std::cerr << "Error! syntax challenge110 <inputfile>!\n" ;
      return 1 ;
  }
  const char* const infile = argv[1] ;
  std::ifstream myIn( infile , std::ios_base::in ) ;
  if ( ! myIn.is_open( ) ) {
      std::cerr << "error opening " << infile << '\n' ;
      return 2 ;
  }
  std::vector<std::string> validLines ;
  std::string regexstr(R"((\s*\+\d{2}|\(\d{2}\)|\d{4})\s\d{10})") ;
  std::regex rgx( regexstr ) ;
  while ( myIn ) {
      std::string line ;
      std::getline( myIn , line ) ;
      if ( std::regex_search( line , rgx ) )
    validLines.push_back( line ) ;
  }
  myIn.close( ) ;
  for ( auto s : validLines )
      std::cout << s << std::endl ;
  return 0 ;
}
