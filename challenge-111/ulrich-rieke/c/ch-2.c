#include <string>
#include <iostream>
#include <fstream>
#include <algorithm>
#include <locale>
#include <cstring>

void makeCaseInsensitive( std::string & str ) {
  for ( auto & c : str )
      c = std::tolower( c ) ;
}

bool noWordChange( std::string &word ) {
  makeCaseInsensitive( word ) ;
  std::string comparison( word ) ;
  std::sort(comparison.begin( ) , comparison.end( ) ) ;
  return comparison == word ;
}

int main( int argc, char * argv[] ) {
  std::ifstream infile( argv[1] , std::ios_base::in ) ;
  if ( ! infile.is_open( ) ) {
      std::cerr << "Couldn't open file " << argv[1] << " !" << std::endl ;
      return 1 ;
  }
  std::string longestUnchanged( " " ) ;
  while ( infile ) {
      std::string line ;
      std::getline( infile , line ) ;
      if ( noWordChange( line ) ) {
    if (line.length( ) > longestUnchanged.length( ) )
        longestUnchanged = line ;
      }
  }
  infile.close( ) ;
  std::cout << "In the given dictionary, the longest word unaffected "
      << "by alphabetic ordering is\n" << longestUnchanged << " !\n" ;
  return 0 ;
}
