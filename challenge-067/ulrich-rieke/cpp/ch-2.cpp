#include <string>
#include <iostream>
#include <map>
#include <vector>

std::vector<std::string> combineStrings( const std::string & worda ,
      const std::string & wordb) {
  std::vector<std::string> combis ;
  int lena = worda.size( ) ;
  int lenb = wordb.size( ) ;
  if ( lena > 0 && lenb == 0 ) {
      for ( int i = 0 ; i < lena ; i++ ) {
    combis.push_back( worda.substr( i , 1 ) ) ;
      }
  }
  if ( lena == 0 && lenb > 0 ) {
    for ( int i = 0 ; i < lenb ; i++ ) {
    combis.push_back( wordb.substr( i , 1 ) ) ;
      }
  }
  if ( lena > 0 && lenb > 0 ) {
      for ( int i = 0 ; i < lena ; i++ ) {
    for ( int j = 0 ; j < lenb ; j++ ) {
        combis.push_back( worda.substr( i , 1 ) + wordb.substr( j , 1 ) ) ;
    }
      }
  }
  return combis ;
}

std::vector<std::string> combineStringsWithString( std::vector<std::string>
      & words, std::string & expression ) {
  std::vector<std::string> newWords ;
  if ( ! expression.empty( ) ) {
      int len = expression.size( ) ;
      for ( auto word : words ) {
    for ( int i = 0 ; i < len ; i++ ) {
        word.append( expression.substr( i , 1 )) ;
        newWords.push_back( word ) ;
    }
      }
  }
  else
      newWords = words ;
  return newWords ;
}

int main( int argc, char * argv[] ) {
  std::map<std::string, std::string> phone { {"1" , "_,@"} , {"2", "ABC" },
      {"3" , "DEF"} , {"4" , "GHI"} , {"5" , "JKL"} , {"6" , "MNO"} ,
      {"7" , "PQRS"} , {"8", "TUV"} , {"9", "WXYZ"} , {"0" , ""}} ;
  std::string input( argv[1] ) ;
  std::vector<std::string> combis ;
  int len = input.size( ) ;
  if ( len == 1 ) {
      std::string word ( phone[ input ] ) ;
      if ( !word.empty( ) ) {
    for ( int i = 0 ; i < word.length( ) ; i++ ) {
        combis.push_back( word.substr( i , 1 ) ) ;
    }
      }
  }
  if ( len == 2 ) {
      combis = combineStrings( phone[ input.substr( 0 , 1 )] ,
        phone[ input.substr( 1 , 1 )] ) ;
  }
  if ( len > 2 ) {
      combis = combineStrings( phone[ input.substr( 0 , 1 )] ,
        phone[ input.substr( 1 , 1 )] ) ;
      for ( int i = 2 ; i < len ; i++ ) {
    combis = combineStringsWithString( combis,
          phone[ input.substr( i , 1 )] ) ;
      }
  }
  for ( auto & str : combis ) {
      std::cout << str << " " ;
  }
  std::cout << std::endl ;
  return 0 ;
}
