#include <string>
#include <sstream>
#include <iostream>
#include <algorithm>
#include <vector>
#include <cctype>
#include <iterator>
#include <regex>

std::vector<std::string> split( const std::string & text , const char 
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

char to_lowercase( unsigned char c ) {
   return std::tolower( c ) ;
}

std::string to_lower( const std::string word ) {
   std::string transformed { word } ;
   std::transform( transformed.begin( ) , transformed.end( ) ,
         transformed.begin( ) , to_lowercase ) ; 
   return transformed ;
}

int main( ) {
   std::cout << "Enter a sentence!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto rx = std::regex { R"(\s+)"} ;
   auto newtext = std::regex_replace( line, rx , " " ) ;
   auto tokens { split( newtext , ' ' ) } ;
   std::sort( tokens.begin( ) , tokens.end( ) , []( const auto a , const
            auto b ){ return to_lower( a ) < to_lower( b ) ; } ) ;
   std::copy( tokens.begin( ) , tokens.end( ) ,
         std::ostream_iterator<std::string>( std::cout , " " )) ;
   std::cout << '\n' ;
   return 0 ;
}
