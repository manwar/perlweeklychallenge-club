#include <iostream>
#include <string>
#include <cctype>
#include <algorithm>

auto converter = []( char c ) {
   if ( islower( c ) ) {
      return toupper( c ) ;
   }
   else {
      return tolower( c ) ;
   }
} ;

std::string convert( std::string word ) {
   std::transform( word.begin( ) , word.end( ) , word.begin( ) , converter ) ;
   return word ;
}

int main( ) {
   std::cout << "Enter a word consisting of English letters only!\n" ;
   std::string word ;
   std::cin >> word ;
   std::cout << convert( word ) << '\n' ;
   return 0 ;
}
