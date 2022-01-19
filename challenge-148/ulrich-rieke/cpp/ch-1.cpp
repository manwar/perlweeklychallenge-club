#include <iostream>
#include <string>
#include <array>
#include <vector>

int main( ) {
  std::array<std::string, 9> smallNumbers { "one" , "two" , "three" , "four" ,
      "five" , "six" , "seven" , "eight" , "nine" } ;
  std::array<std::string, 10> teens { "ten" , "twenty" , "thirty" , "forty" ,
      "fifty" , "sixty" , "seventy" , "eighty" , "ninety" , "hundred" } ;
  std::vector<int> ebannumbers ;
  for( int i = 0 ; i < 9 ; i++ ) {
      if ( smallNumbers[ i ].find( 'e' ) == std::string::npos )
    ebannumbers.push_back( i + 1 ) ;
  }
  for( int i = 0 ; i < 10 ; i++ ) {
      if ( teens[ i ].find( 'e' ) == std::string::npos ) {
    ebannumbers.push_back( (i + 1 ) * 10 ) ;
    for ( int j = 0 ; j < 9 ; j++ ) {
        if ( smallNumbers[j].find( 'e' ) == std::string::npos ) {
          ebannumbers.push_back( (i + 1 ) * 10 + j + 1 ) ;
        }
    }
      }
  }
  for ( int num : ebannumbers ) {
      std::cout << num << " " ;
  }
  std::cout << std::endl ;
  return 0 ;
}
