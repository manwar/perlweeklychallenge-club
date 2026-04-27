#include <iostream>
#include <vector>
#include <sstream>
#include <string>
#include <regex>
#include <map>
#include <algorithm>
#include <cctype>
using namespace std::string_literals ;

std::vector<std::string> split( const std::string & text , const char
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

std::string convert( std::string word ) {
   std::string result ;
   for ( char c : word ) {
      if ( std::isupper( c ) )
         result.push_back( std::tolower( c ) ) ;
      if ( std::islower( c ) ) 
         result.push_back( c ) ;
   }
   return result ;
}

int main( ) {
   std::cout << "Enter a paragraph!\n" ;
   std::string paragraph ;
   std::getline( std::cin , paragraph ) ;
   auto tokens { split( paragraph , ' ' ) } ;
   std::cout << "Enter some banned words separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto banned { split( line, ' ' ) } ;
   if ( tokens.size( ) == 1 ) { //punctuation as delimiter
      std::regex pattern (R"([[:punct:]])") ;
      auto newtext = std::regex_replace( paragraph , pattern , " "s ) ;
      tokens = split( newtext , ' ' ) ;
   }
   std::transform( tokens.begin( ) , tokens.end( ) , tokens.begin( ) , 
         convert ) ;
   std::map<std::string , int> frequencies ;
   for ( auto w : tokens ) {
      if ( std::find( banned.begin( ) , banned.end( ) , w ) == 
            banned.end( ) ) {
         frequencies[w]++ ;
      }
   }
   std::cout << (std::max_element( frequencies.begin( ) ,
         frequencies.end( ) , [] ( const auto a , const auto b ) {
         return a.second < b.second ; }))->first << '\n' ;
   return 0 ;
}

