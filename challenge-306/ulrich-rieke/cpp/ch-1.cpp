#include <string>
#include <iostream>
#include <vector>
#include <sstream>
#include <numeric>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

int find_subarray_sum( const std::vector<int> & numbers , int len ) {
   if ( len == 1 || len == numbers.size( ) ) {
      return std::accumulate( numbers.begin( ) , numbers.end( ) , 0 ) ;
   }
   else {
      int total = 0 ;
      int arraylen = numbers.size( ) ;
      for ( int i = 0 ; i < arraylen - len + 1 ; i++ ) {
	 std::vector<int> partialarray( numbers.begin( ) + i ,
	       numbers.begin( ) + i + len ) ;
	 total += std::accumulate( partialarray.begin( ) , partialarray.end( ) ,
	       0 ) ;
      }
      return total ;
   }
}

int main( ) {
   std::cout << "Enter some positive integers separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) {
      numbers.push_back( std::stoi( s ) ) ;
   }
   std::vector<int> sums ;
   for ( int l = 0 ; l < numbers.size( ) + 1 ; l++ ) {
      if ( l % 2 == 1 ) {
	 sums.push_back( find_subarray_sum( numbers , l ) ) ;
      }
   }
   std::cout << std::accumulate( sums.begin( ) , sums.end( ) , 0 ) << '\n' ;
   return 0 ;
}
