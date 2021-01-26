#include <iostream>
#include <cstdlib>
#include <string>
#include <algorithm>
#include <iterator>

char findCipher( char c, int shift ) {
  static const std::string alphabet {"ABCDEFGHIJKLMNOPQRSTUVWXYZ"} ;
  std::string mapped { alphabet.substr(26 - shift) } ;
  std::reverse ( mapped.begin( ) , mapped.end( ) ) ;
  mapped.append( alphabet.substr(0 , 26 - shift ) ) ;
  if ( c == ' ' )
      return ' ' ;
  else {
      auto found = std::find( alphabet.begin( ) , alphabet.end( ) , c );
      return mapped[ static_cast<int>(std::distance(alphabet.begin( ), found))] ;
  }
}

int main( int i , char* argv[ ] ) {
  if ( i != 3 ) {
      std::cerr << "usage: challenge097 <capital letter string> <leftshift>!\n" ;
      return 1 ;
  }
  int leftshift = std::atoi( argv[ 2 ] ) ;
  int realshift = leftshift % 26 ;
  std::string plaintext( argv[ 1 ] ) ;
  int len = plaintext.length( ) ;
  std::string ciphertext ;
  for ( char letter : plaintext ) {
      ciphertext.push_back( findCipher ( letter , realshift ) ) ;
  }
  std::cout << ciphertext << std::endl ;
  return 0 ;
}
