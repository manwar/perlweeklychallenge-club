#include <fstream>
#include <string>
#include <cstdlib>
#include <iostream>
#include <string>
#include <vector>

int main( int argc, char * argv[] ) {
  const char * const infile =  argv[ 1 ]  ;
  int a = std::atoi( argv[ 2 ] ) ;
  int b = std::atoi( argv[ 3 ] ) ;
  std::ifstream instream( infile , std::ios::in ) ;
  if ( ! instream ) {
      std::cerr << "Cannot open file " << argv[ 1 ] << " !\n" ;
      return 1 ;
  }
  std::string line ;
  int n = 1 ;
  std::vector<std::string> lines ;
  while( instream.good( )) {
      std::getline( instream , line ) ;
      if ( n >= a && n <= b ) {
    lines.push_back( line ) ;
      }
      if ( n > b ) {
    break ;
      }
      n++ ;
  }
  instream.close( ) ;
  for ( std::string & s : lines ) {
      std::cout << s << std::endl ;
  }
  return 0 ;
}
