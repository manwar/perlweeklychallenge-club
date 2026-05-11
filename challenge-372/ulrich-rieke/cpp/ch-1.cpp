#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <regex>
#include <algorithm>

std::vector<std::string> split( const std::string & text , const char
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter a text with words surrounded by spaces!\n" ;
   std::string text ;
   std::getline( std::cin , text ) ;
   std::string output ;
   int totalspaces = std::count( text.begin( ) , text.end( ) , ' ' )  ;
   std::regex startpattern {R"(^\s+)"} ;
   std::regex endpattern {R"(\s+$)" } ;
   std::regex midpattern {R"(\s+)"} ;
   std::string empty {""} ;
   auto newtext = std::regex_replace( text , startpattern , empty ) ;
   newtext = std::regex_replace( newtext , endpattern , empty ) ;
   auto match = std::smatch{} ;
   if ( std::regex_search( newtext , match , midpattern ) ) {
      newtext = std::regex_replace( newtext , midpattern,
            std::string { " " } ) ;
      auto allWords { split( newtext , ' ' ) } ;
      int len = allWords.size( ) ;
      int gapspaces = totalspaces / ( len - 1 ) ;
      for ( int i = 0 ; i < len - 1 ; i++ ) {
         output += allWords[i] ;
         for ( int n = 0 ; n < gapspaces ; n++ ) {
            output.push_back( ' ' ) ;
         }
      }
      output += allWords[len - 1] ;
      for ( int i = 0 ; i < totalspaces - gapspaces * ( len - 1 ) ; i++ ) {
         output.push_back( ' ' ) ;
      }
   }
   else {
      output += newtext ;
      for ( int i = 0 ; i < totalspaces ; i++ ) {
         output.push_back( ' ' ) ;
      }
   }
   std::cout << output << '\n' ;
   return 0 ;
}
