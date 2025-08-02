#include <iostream>
#include <string>
#include <algorithm>
#include <utility>
#include <sstream>
#include <vector>

std::vector<std::string> tokenize( const std::string & text , char delimiter ) {
   std::istringstream allTokens { text } ;
   std::vector<std::string> tokens ;
   std::string tok ;
   while ( std::getline( allTokens , tok , delimiter ) ) {
      tokens.push_back( tok ) ;
   }
   return tokens ;
}

int main( ) {
   std::cout << "Enter some letters, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> letterstrings { tokenize( line , ' ' ) } ;
   std::cout << "Enter some weights, separated by blanks!\n" ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> weightstrings { tokenize( line , ' ' ) } ;
   std::vector<std::pair<char , int>> allPairs ;
   for ( int i = 0 ; i < letterstrings.size( ) ; i++ ) {
      allPairs.push_back( std::make_pair( letterstrings[i].front( ) , std::stoi( 
		  weightstrings[i].substr( 0 , 1 ) ) ) ) ;
   }
   std::sort( allPairs.begin( ) , allPairs.end( ) , []( const auto & p1 , const auto & p2) {
	 return p1.second < p2.second ; } ) ;
   for ( auto p : allPairs ) 
      std::cout << p.first ;
   std::cout << '\n' ;
   return 0 ;
}
      
