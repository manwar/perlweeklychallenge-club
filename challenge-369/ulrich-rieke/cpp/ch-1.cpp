#include <iostream>
#include <sstream>
#include <algorithm>
#include <vector>
#include <string>
#include <cctype>
#include <numeric>

std::vector<std::string> split( const std::string & text , const char
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) )
      tokens.push_back( word ) ;
   return tokens ;
}

std::string trimleft( const std::string & text ) {
   auto pos { text.find_first_not_of( ' ' ) } ;
   return text.substr( pos , text.length( ) - pos ) ;
}

std::string trimright( const std::string & text ) {
   auto pos { text.find_last_not_of( ' ' ) } ;
   return text.substr( 0 , pos + 1 ) ;
}

std::string weed_out_non_letters( const std::string & word , const 
      std::vector<char> & letters ) {
   std::string corrected ;
   for ( int i = 0 ; i < word.length( ) ; i++ ) {
      auto pos = std::find( letters.begin( ) , letters.end( ) , word[i] ) ;
      if ( pos != letters.end( ) ) {
         corrected.push_back( word[i] ) ;
      }
   }
   return corrected ;
}

int main( ) {
   std::cout << "Enter a sentence!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   line = trimleft( line ) ;
   line = trimright( line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<char> bigLetters( 26 ) ;
   std::iota( bigLetters.begin( ) , bigLetters.end( ) , 'A' ) ;
   std::vector<char> smallLetters( 26 ) ;
   std::iota( smallLetters.begin( ) , smallLetters.end( ) , 'a' ) ;
   std::vector<char> letters { bigLetters.begin( ) , bigLetters.end( ) } ;
   for ( char c : smallLetters ) {
      letters.push_back( c ) ;
   }
   std::string output { "#" } ;
   std::string start { tokens[0] } ;
   start = weed_out_non_letters( start , letters ) ;
   if ( std::isupper( start[0] )) {
      start[0] = std::tolower( start[0] ) ;
   }
   for ( int i = 1 ; i < start.length( ) ; i++ ) {
      start[i] = std::tolower( start[i] ) ;
   }
   output += start ;
   for ( int i = 1 ; i < tokens.size( ) ; i++ ) {
      std::string current { tokens[i] } ;
      current = weed_out_non_letters( current , letters ) ;
      if ( std::islower( current[0] )) {
         current[0] = std::toupper( current[0] ) ;
      }
      for ( int pos = 1 ; pos < current.length( ) ; pos++ ) {
         current[pos] = std::tolower( current[pos] ) ;
      }
      output += current ;
   }
   if ( output.length( ) > 100 ) {
      output = output.substr( 0 , 100 ) ;
   }
   std::cout << output << '\n' ;
   return 0 ;
}
