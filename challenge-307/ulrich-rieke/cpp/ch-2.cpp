#include <string>
#include <iostream>
#include <vector>
#include <sstream>
#include <algorithm>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

bool areAnagrams( std::string firstWord , std::string secondWord ) {
   std::sort( firstWord.begin( ) , firstWord.end( ) ) ;
   std::sort( secondWord.begin( ) , secondWord.end( ) ) ;
   return (firstWord == secondWord ) ;
}

int count_anagrams( const std::vector<std::string> & words ) {
   int len = words.size( ) ;
   int anagramcount = 0 ;
   for ( int i = 0 ; i < len - 1 ; i++ ) {
      if ( areAnagrams( words[i] , words[i + 1] ) ) 
	 anagramcount++ ;
   }
   return anagramcount ;
}

int main( ) {
   std::cout << "Enter some words separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::cout << ( tokens.size( ) - count_anagrams( tokens ) ) << '\n' ;
   return 0 ;
}
