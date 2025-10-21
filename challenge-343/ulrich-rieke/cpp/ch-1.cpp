#include <iostream>
#include <vector>
#include <sstream>
#include <string>
#include <algorithm>
#include <cstdlib>

std::vector<std::string> split( const std::string & text , const char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

//we want to find the minimum absolute value!
int main( ) {
   std::cout << "Enter some integers separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> differences ;
   for ( auto s : tokens ) 
      differences.push_back( std::abs(std::stoi( s ) )) ;
   std::cout << *std::min_element( differences.begin( ) , differences.end( ) ) << 
      '\n' ;
   return 0 ;
}
