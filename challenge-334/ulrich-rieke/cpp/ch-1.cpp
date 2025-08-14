#include <iostream>
#include <sstream>
#include <vector>
#include <numeric>
#include <string>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some integers separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto numarray { split( line , ' ' ) } ;
   std::vector<int> numbers , indices ;
   for ( auto s : numarray ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::cout << "Enter some valid indices into the array!\n" ;
   std::getline( std::cin , line ) ;
   auto indexes { split( line , ' ' ) } ;
   for ( auto s : indexes ) 
      indices.push_back( std::stoi( s ) ) ;
   std::cout << std::accumulate( numbers.begin( ) + indices[0] , 
	 numbers.begin( ) + indices[1] + 1 , 0 ) << '\n' ;
   return 0 ;
}
