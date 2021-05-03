#include <iostream>
#include <string>
#include <fstream>
#include <vector>

std::vector<std::string> splitString( const std::string & word, char
      separator ) {
  std::vector<std::string> parts ;
  std::string::size_type last_found = 0 ;
  std::string::size_type pos = word.find_first_of( separator , last_found ) ;
  while ( pos != std::string::npos ) {
      parts.push_back( word.substr(last_found , pos - last_found)) ;
      last_found = pos + 1 ;
      pos = word.find_first_of( separator, last_found ) ;
  }
  parts.push_back( word.substr( last_found ) ) ;
  return parts ;
}

int main( int argc, char * argv[] ) {
  if ( argc != 2 ) {
      std::cerr << "Error! syntax: challenge110_2 <source file>!\n" ;
      return 1 ;
  }
  const char * const infile = argv[ 1 ] ;
  std::ifstream myIn( infile , std::ios_base::in ) ;
  if ( ! myIn.is_open( )) {
      std::cerr << "cannot open file " << argv[1] << "!\n" ;
      return 2 ;
  }
  std::vector<std::string> partsInLine ;
  std::vector<std::string> allWords ;
  std::string line ;
  int fields = 0 ;
  while ( myIn ) {
      std::getline( myIn , line ) ;
      partsInLine = splitString( line , ',' ) ;
      if ( ! line.empty( ) ) {
    fields = partsInLine.size( ) ;
    for ( auto s : partsInLine )
        allWords.push_back( s ) ;
      }
  }
  myIn.close( ) ;
  std::vector<std::string> myOut ;
  for ( int start = 0 ; start < fields ; start++ ) {
      myOut.clear( ) ;
      myOut.push_back( allWords[ start ] ) ;
      for ( int jumpTo = start + fields ; jumpTo < allWords.size( ) ; jumpTo += fields )
    myOut.push_back( allWords[ jumpTo ] ) ;
      int count = 0 ;
      for ( auto s : myOut ) {
    std::cout << s ;
    if ( count < myOut.size( ) - 1 )
        std::cout << ", " ;
    count++ ;
      }
      std::cout << std::endl ;
    }
  return 0 ;
}
