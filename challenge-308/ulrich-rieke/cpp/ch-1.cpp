#include <iostream>
#include <string>
#include <sstream>
#include <vector>
#include <map>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

int main( ) {
   std::cout << "Enter some words separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto firstTokens { split( line , ' ' ) } ;
   std::string secondline ;
   std::cout << "Enter some more words separated by whitespace!\n" ;
   std::getline( std::cin , secondline ) ;
   auto secondTokens { split( secondline , ' ' ) } ;
   std::map<std::string , int> firstFrequency , secondFrequency ;
   int common = 0 ;
   for ( auto s : firstTokens ) 
      firstFrequency[s]++ ;
   for ( auto s : secondTokens ) 
      secondFrequency[s]++ ;
   for ( auto aPair : firstFrequency ) {
      if ( secondFrequency.find( aPair.first ) != secondFrequency.end( ) ) {
	 common++ ;
      }
   }
   std::cout << common << '\n' ;
   return 0 ;
}
