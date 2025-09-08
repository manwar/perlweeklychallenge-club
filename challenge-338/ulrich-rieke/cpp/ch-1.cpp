#include <vector>
#include <string>
#include <iostream>
#include <numeric>
#include <algorithm>
#include <sstream>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some integers separated by whitespace , <return> to end!\n" ;
   std::string line ;
   std::vector<std::vector<int>> matrix ;
   std::getline( std::cin , line ) ;
   while ( ! line.empty( ) ) {
      std::vector<int> row ;
      auto tokens { split( line , ' ' ) } ;
      for ( auto s : tokens ) 
	 row.push_back( std::stoi( s ) ) ;
      matrix.push_back( row ) ;
      std::getline( std::cin , line ) ;
   }
   std::vector<int> rowsums ;
   for ( auto it = matrix.begin( ) ; it != matrix.end( ) ; ++it ) {
      rowsums.push_back( std::accumulate( it->begin( ) , it->end( ) , 0 )) ;
   }
   std::cout << *std::max_element( rowsums.begin( ) , rowsums.end( ) ) << '\n' ;
   return 0 ;
}
