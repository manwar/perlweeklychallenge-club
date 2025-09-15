#include <vector>
#include <iostream>
#include <sstream>
#include <algorithm>
#include <string>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::string word ;
   std::istringstream istr { text } ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some height differences separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> differences , heights ;
   for ( auto s : tokens ) {
      differences.push_back( std::stoi( s ) ) ;
   }
   heights.push_back( 0 ) ;
   int currentHeight = 0 ;
   for ( auto it = differences.begin( ) ; it != differences.end( ) ; ++it ) {
      currentHeight += *it ;
      heights.push_back( currentHeight ) ;
   }
   std::cout << *std::max_element( heights.begin( ) , heights.end( ) ) << 
      '\n' ;
   return 0 ;
}
      
