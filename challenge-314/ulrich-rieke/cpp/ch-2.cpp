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

int main( ) {
   std::cout << "Enter some words of equal length separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   int len = tokens[0].length( ) ;
   int wordslen = tokens.size( ) ;
   std::vector<std::string> transposed ;
   for ( int i = 0 ; i < len ; i++ ) {
      std::string transpo ;
      for ( int w = 0 ; w < wordslen ; w++ ) {
	 transpo += tokens[w].substr( i , 1 ) ;
      }
      transposed.push_back( transpo ) ;
   }
   std::cout << std::count_if( transposed.begin( ) , transposed.end( ) , 
	 []( const auto & s){ return ! std::is_sorted( s.begin( ) , 
	    s.end( ) ) ; }) << '\n' ;
   return 0 ;
}

