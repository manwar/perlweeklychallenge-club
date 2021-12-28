#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

bool isPalindrome( std::string & word ) {
  std::string comparedTo( word ) ;
  std::reverse( comparedTo.begin( ) , comparedTo.end( ) ) ;
  return comparedTo == word ;
}

int main( int argc , char * argv[ ] ) {
  std::string s( argv[ 1 ] ) ;
  std::vector<std::string> palindromes ;
  int len = s.length( ) ;
  for ( int i = 0 ; i < len ; i++ ) {
      if ( std::find( palindromes.begin( ) , palindromes.end( ) ,
          s.substr( i , 1 ) ) == palindromes.end( ) )
    palindromes.push_back( s.substr( i , 1 ) ) ;
      int diff = len - i ;
      while ( diff > 1 ) {
    std::string wordpart { s.substr( i , diff ) } ;
    if ( isPalindrome( wordpart ) && std::find( palindromes.begin( ) ,
          palindromes.end( ) , wordpart ) == palindromes.end( ) ) {
        palindromes.push_back( wordpart ) ;
        break ;
    }
        else {
        diff-- ;
    }
      }
  }
  for ( auto str : palindromes ) {
      std::cout << str << ' ' ;
  }
  std::cout << std::endl ;
  return 0 ;
}
