#include <iostream>
#include <sstream>
#include <vector>
#include <algorithm>
#include <string>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

bool condition( const std::string & word , const std::vector<std::string> & 
      forbidden ) {
   return std::all_of( forbidden.begin( ) , forbidden.end( ) , [word]( const auto & w ) {
	 return word.find( w ) == std::string::npos ; } ) ;
}

int main( ) {
   std::cout << "Enter some words with English letters only!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto words { split( line , ' ' ) } ;
   std::cout << "Enter some letters , separated by whitespace!\n" ;
   std::getline( std::cin , line ) ;
   auto letters { split( line , ' ' ) } ;
   std::cout << std::count_if( words.begin( ) , words.end( ) , [&letters](const auto & w) {
	 return condition( w , letters ) ; } ) << '\n' ;
   return 0 ;
}
