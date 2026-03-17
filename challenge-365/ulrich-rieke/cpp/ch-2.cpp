#include <iostream>
#include <string>
#include <sstream>
#include <string>
#include <vector>
#include <algorithm>
#include <regex>
#include <cctype>

std::vector<std::string> split( const std::string & text , const char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

bool isValid( const std::string & word ) {
   std::vector<bool> truthvalues ;
   std::regex firstPattern { R"(^\D+$)" } ;
   truthvalues.push_back( std::regex_match( word.begin( ) , word.end( ) ,
            firstPattern ) ) ;
   auto found = word.find( "-") ;
   if ( found != std::string::npos ) {
      int hyphens = std::count( word.begin( ) , word.end( ) , '-' ) ;
      bool condition = false ;
      if ( hyphens == 1 ) {
         condition = ! word.ends_with('-' ) && std::islower( word[found - 1] )
            && std::islower( word[found + 1]) ;
      }
      truthvalues.push_back( condition ) ;
   }
   else {
      truthvalues.push_back( true ) ;
   }
   found = word.find_first_of( "!,." ) ;
   std::string wanted { "!,." } ;
   if ( found != std::string::npos ) {
      bool condition = wanted.contains( word.substr( word.length( ) - 1 , 1 ) ) && 
         std::count_if( word.begin( ) , word.end( ) , [wanted]( auto c ) { return 
               wanted.contains( c ) ; } ) ;
      truthvalues.push_back( condition ) ;
   }
   else {
      truthvalues.push_back( true ) ;
   }
   return std::all_of( truthvalues.begin( ) , truthvalues.end( ), []( auto b) 
         { return b ; }) ;
}

int main( ) {
   std::cout << "Enter a sentence!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::cout << std::count_if( tokens.begin( ) , tokens.end( ) , []( auto t) { 
         return isValid( t ) ; } ) << '\n' ;
   return 0 ;
}
