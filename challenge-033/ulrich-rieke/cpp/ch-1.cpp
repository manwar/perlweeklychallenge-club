#include <iostream>
#include <map>
#include <cctype>
#include <fstream>
#include <algorithm>
#include <string>

char myTransformer( char d ) {
  if ( std::isupper( d ) )
      return std::tolower( d ) ;
  else
      return d ;
}

int main( int argc, char* argv[] ) {
  for ( int i = 1 ; i < argc ; i++ ) {
      std::string file( argv[ i ] ) ;
      std::ifstream infile( file , std::ios::binary | std::ios::in ) ;
      if ( infile ) {
    std::map<char, int> frequencies ;
    while ( infile.good( ) ) {
        std::string line ;
        std::getline( infile, line ) ;
        std::transform( line.begin( ) , line.end( ) , line.begin( ) ,
          myTransformer ) ;
        for ( char c : line ) {
          if ( std::isalpha( c ) ) {
          frequencies[c]++ ;
          }
        }
    }
    infile.close( ) ;
    std::cout << "Letter frequency for file " << file << " :\n" ;
    for ( auto & p : frequencies ) {
        std::cout << p.first << ": " << p.second << std::endl ;
    }
      }
      else {
    std::cout << "Can't open file " << file << " !\n" ;
      }
  }
}
