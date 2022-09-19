#include <string>
#include <iostream>
#include <algorithm>
#include <vector>
#include <fstream>

int main( ) {
  std::string source { "inputfiles.txt" } ;
  std::ifstream instream ( source ) ;
  std::vector<std::string> allFiles ;
  if ( ! instream ) {
      std::cerr << "file " << source << " could not be found!\n" ;
      std::exit( 1 ) ;
  }
  while ( instream.good( ) ) {
      std::string line ;
      std::getline( instream , line ) ;
      if ( line.length( ) > 0 ) {
    allFiles.push_back( line ) ;
      }
  }
  instream.close( ) ;
  int len = allFiles.size( ) ;
  int count = 0 ;
  std::string compareTo { *allFiles.begin( ) } ;
  for ( int i = 1 ; i < compareTo.length( ) + 1 ; i++ ) {
      std::string toBeFound { compareTo.substr( 0 , i ) } ;
      if ( std::count_if( allFiles.begin( ) + 1 , allFiles.end( ) , [toBeFound] ( const
          auto & a ) { return a.find( toBeFound, 0 ) != std::string::npos ; })
    == len - 1 ) {
    count++ ;
      }
      else {
    break ;
      }
  }
  std::cout << compareTo.substr( 0 , count ) << std::endl ;
}
