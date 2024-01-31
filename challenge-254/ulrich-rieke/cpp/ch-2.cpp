#include <iostream>
#include <string>
#include <cctype>
#include <list>
#include <algorithm>

int main( ) {
   std::cout << "Please enter a word!\n" ;
   std::string word ;
   std::cin >> word ;
   std::string vowels {"aeiouAEIOU"} ;
   std::list<char> vowels_contained ;
   for ( int i = 0 ; i < word.length( ) ; i++ ) {
      if ( vowels.find( word.substr( i , 1 ) ) != std::string::npos ) 
	 vowels_contained.push_back( word[ i ] ) ;
   }
   std::string changed ;
   for ( auto c : word ) {
      if ( vowels.find( c ) != std::string::npos ) {
	 char next_one = vowels_contained.back( ) ;
	 if ( changed.empty( ) ) {
	    changed.push_back( toupper( next_one ) ) ;
	 }
	 else {
	    changed.push_back( tolower( next_one ) ) ;
	 }
	 vowels_contained.pop_back( ) ;
      }
      else {
	 changed.push_back( c ) ;
      }
   }
   std::cout << changed << '\n' ;
   return 0 ;
}
