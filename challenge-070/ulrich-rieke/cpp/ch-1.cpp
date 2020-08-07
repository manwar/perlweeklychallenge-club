#include <string>
#include <iostream>
#include <cstdlib>

void swapLetters( std::string & word, int firstPos, int secondPos ) {
  std::string temp( word.substr( secondPos , 1 ) ) ;
  int len = word.length( ) ;
  if ( secondPos < len - 1 )
      word = word.substr( 0 , secondPos ) + word.substr( firstPos, 1 )
    + word.substr( secondPos + 1 ) ;
  else
      word = word.substr( 0 , secondPos )  + word.substr( firstPos, 1 ) ;
  if ( firstPos > 0 )
      word = word.substr( 0 , firstPos ) + temp + word.substr( firstPos
        + 1 ) ;
  else
      word = temp + word.substr( firstPos + 1 ) ;
}

int main( int argc, char * argv[] ) {
  std::string word( argv[ 1 ] ) ;
  int c = std::atoi( argv[ 2 ] ) ;
  int o = std::atoi( argv[ 3 ] ) ;
  int n = word.length( ) ;
  for ( int i = 1 ; i < c + 1 ; i++ )
      swapLetters( word , i % n , ( i + o ) % n ) ;
  std::cout << word << std::endl ;
  return 0 ;
}
