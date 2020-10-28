#include <string>
#include <vector>
#include <iostream>
#include <algorithm>

std::vector<std::string> splitString( const std::string & line , char sep) {
  std::vector<std::string> words ;
  std::string::size_type oldpos = 0 ;
  std::string::size_type newpos ;
  do {
      newpos = line.find_first_of( sep , oldpos ) ;
      words.push_back( line.substr( oldpos, newpos - oldpos ) ) ;
      oldpos = newpos + 1 ;
  } while ( newpos != std::string::npos ) ;
  return words ;
}

int main( int argc, char * argv[] ) {
  std::string theLine ( argv[ 1 ] ) ;
  int len = 0 ;
  std::vector<std::string> theWords = splitString( theLine , ' ' ) ;
  int wordsSize = theWords.size( ) ;
  for ( int i = 1 ; i < wordsSize - 1 ; i++ )
      len += theWords[ i ].length( ) ;
  std::cout << len << std::endl ;
  return 0 ;
}
