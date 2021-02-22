#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

int main( int argc, char * argv[] ) {
  std::string line( argv[1] ) ;
  std::vector<std::string> words ;
  std::string word ;
  for (std::string::const_iterator sci = line.begin( ) ; sci != line.end( ) ;
    sci++ ) {
      if ( *sci == ' ' ) {
    if ( word.length( ) != 0 ) {
        words.push_back( word ) ;
        word.clear( ) ;
    }
      }
      else { // no white space
    word.push_back( *sci ) ;
      }
  }
  if ( word.length( ) != 0 ) //the last word might not be followed by white space
      words.push_back( word ) ;
  std::reverse( words.begin( ) , words.end( ) ) ;
  int wordnumber = words.size( ) ;
  int counter = 0 ;
  std::string output ;
  for ( auto theWord : words ) {
      output.append( theWord ) ;
      if ( counter < wordnumber - 1 )
    output.append( " " ) ;
      counter++ ;
  }
  std::cout << output << std::endl ;
  return 0 ;
}
