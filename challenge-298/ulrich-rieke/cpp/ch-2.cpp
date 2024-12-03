#include <iostream>
#include <string>
#include <algorithm>
#include <utility>
#include <numeric>
#include <sstream>
#include <vector>

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
   std::cout << "Every first, third and so on integer should be unique!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::vector<std::pair<int , int>> allPairs ;
   int len = static_cast<int>(numbers.size( ) ) ;
   int current = 0 ;
   while ( current < len - 1 ) {
      allPairs.push_back( std::make_pair( numbers[current] ,
	       numbers[current + 1] )) ;
      current += 2 ;
   }
   std::vector<int> solution ;
   for ( int i = 0 ; i < allPairs.size( ) ; i++ ) {
      std::vector<std::pair<int , int>> selected ;
      int comp = allPairs[i].second ;
      std::copy_if( allPairs.begin( ) , allPairs.end( ) , std::back_inserter( 
	       selected ) , [comp]( const auto & p ) { return p.first >= comp ; }) ;
      if ( selected.size( ) == 0 ) {
	 solution.push_back( -1 ) ;
      }
      else {
	 std::vector<int> starts ;
	 for ( const auto p : selected ) 
	    starts.push_back( p.first ) ;
	 int mini = *std::min_element( starts.begin( ) , starts.end( ) ) ;
	 auto pos = std::find_if( allPairs.begin( ) , allPairs.end( ) , [mini] 
	       (const auto & p) { return p.first == mini ; } ) ;
	 solution.push_back( static_cast<int>( std::distance( allPairs.begin( ) , 
		     pos ) ) ) ;
      }
   }
   std::cout << '(' ;
   for ( int i : solution ) 
      std::cout << ' ' << i << ' ' ;
   std::cout << ")\n" ;
   return 0 ;
}
