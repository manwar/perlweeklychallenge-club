#include <iostream>
#include <string>
#include <fstream>
#include <vector>
#include <algorithm>

int main( ) {
  std::string sourcefile {"dictionary.txt"} ;
  std::ifstream source( sourcefile ) ;
  std::vector<std::string> abecedearians ;
  if ( ! source )
      std::cerr << "Cannot find file " << sourcefile << " !\n" ;
  else {
      std::string line ;
      while ( source ) {
    std::getline( source , line ) ;
    std::string compared { line } ;
    std::sort( line.begin( ) , line.end( ) ) ;
    if ( line == compared )
        abecedearians.push_back( line ) ;
      }
      source.close( ) ;
      std::sort( abecedearians.begin( ) , abecedearians.end( ) ,
        []( const auto & s1 , const auto & s2 ) { return s1.length( )
        > s2.length( ) ; }) ;
      for ( auto & s : abecedearians )
    std::cout << s << " " ;
      std::cout << std::endl ;
  }
  return 0 ;
}
