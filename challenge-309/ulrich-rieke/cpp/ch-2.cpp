#include <string>
#include <vector>
#include <iostream>
#include <sstream>
#include <algorithm>
#include <cstdlib>

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
   std::cout << "Enter some integers separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers , differences ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   int len = numbers.size( ) ;
   for ( int start = 0 ; start < len - 1 ; start++ ) {
      for ( int stop = start + 1 ; stop < len ; stop++ ) {
	 differences.push_back( std::abs( numbers[start] - numbers[stop] ) ) ;
      }
   }
   std::cout << *std::min_element( differences.begin( ) , differences.end( ) ) 
      << '\n' ;
   return 0 ;
}
