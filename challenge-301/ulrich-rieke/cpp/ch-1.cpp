#include <vector>
#include <string> 
#include <iostream>
#include <sstream>
#include <algorithm>
#include <numeric>

std::vector<std::string> split( const std::string & text , char delim ) {
   std::istringstream istr { text } ;
   std::vector<std::string> tokens ;
   std::string word ;
   while ( std::getline( istr , word , delim ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

int main( ) {
   std::cout << "Enter some integers separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::sort( tokens.begin( ) , tokens.end( )) ;
   std::vector<long> longnumbers ;
   while ( std::next_permutation( tokens.begin( ) , tokens.end( ) ) ) {
      std::string total = std::accumulate( tokens.begin( ) , 
	    tokens.end( ) , std::string( "" ) , []( auto a , 
	       auto b ){ return a.append( b ) ; } ) ;
      longnumbers.push_back( std::stol( total ) ) ;
   }
   std::cout << *std::max_element( longnumbers.begin( ) , 
	 longnumbers.end( ) ) << '\n' ;
   return 0 ;
}
