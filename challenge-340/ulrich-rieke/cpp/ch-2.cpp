#include <string>
#include <iostream>
#include <sstream>
#include <algorithm>
#include <regex>
#include <vector>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter a string with English letters and numbers only!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   const std::regex re( "^[1-9][0-9]*$" ) ;
   std::vector<int> numbers , differences ;
   for ( auto it = tokens.begin( ) ; it != tokens.end( ) ; ++it ) {
      if ( std::regex_match( *it , re )) 
	 numbers.push_back( std::stoi( *it ) ) ;
   }
   for ( int i = 1 ; i < numbers.size( ) ; i++ ) {
      differences.push_back( numbers[i] - numbers[ i - 1] ) ;
   }
   std::cout << std::boolalpha << std::all_of( differences.begin( ) , differences.end( ),
	 [](const int a){ return a > 0 ; }) << '\n' ;
   return 0 ;
}
