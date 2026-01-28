#include <vector>
#include <iostream>
#include <sstream>
#include <string>
#include <algorithm>
#include <numeric>

std::vector<std::string> split( const std::string & text , const char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int findLength( const std::string input ) {
   std::string numbers { "0123456789" } ;
   if ( std::all_of( input.begin( ) , input.end( ) , [numbers]( char c ) {
            return numbers.find( c ) != std::string::npos ; } )) {
      return std::stoi( input ) ;
   }
   else {
      return static_cast<int>( input.length( ) ) ;
   }
}

int main( ) {
   std::cout << "Enter some alphanumeric strings separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) {
      numbers.push_back( findLength( s ) ) ;
   }
   std::cout << *std::max_element( numbers.begin( ) , numbers.end( ) ) << '\n' ;
   return 0 ;
}
