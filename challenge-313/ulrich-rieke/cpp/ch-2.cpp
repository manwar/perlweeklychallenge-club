#include <iostream>
#include <string>
#include <algorithm>
#include <cctype> 
#include <vector>

int main( ) {
   std::cout << "Enter a string!\n" ;
   std::string word ;
   std::cin >> word ;
   std::vector<char> alphaLetters ;
   for ( auto c : word ) {
      if ( isalpha( c ) ) {
	 alphaLetters.push_back( c ) ;
      }
   }
   std::string reversed ;
   std::reverse( alphaLetters.begin( ) , alphaLetters.end( ) ) ;
   for ( auto c : word ) {
      if ( ! isalpha( c ) ) {
	 reversed.push_back( c ) ;
      }
      else {
	 char firstLetter { alphaLetters.front( ) } ;
	 reversed.push_back( firstLetter ) ;
	 alphaLetters.erase( alphaLetters.begin( ) ) ;
      }
   }
   std::cout << reversed << '\n' ;
   return 0 ;
}

