#include <string>
#include <iostream>
#include <sstream>
#include <algorithm>
#include <vector>
#include <utility>

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
   std::cout << "Enter some 0 or 1 separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens )
      numbers.push_back( std::stoi( s ) ) ;
   int first { numbers[0] } ;
   if ( std::all_of( numbers.begin( ) , numbers.end( ) , [first]( const 
	       int i){ return i == first ; } ) ) 
      std::cout << 0 << '\n' ;
   else {
      int len = numbers.size( ) ;
      std::vector<std::pair<int , int>> allPairs ;
      for ( int start = 0 ; start < len - 1 ; start++ ) {
	 for ( int end = start + 1 ; end < len + 1; end++ ) {
	    int count_ones = std::count( numbers.begin( ) + start , 
		  numbers.begin( ) + end , 1 ) ;
	    int count_zeroes = std::count( numbers.begin( ) + start , 
		  numbers.begin( ) + end  , 0 ) ;
	    allPairs.push_back( std::make_pair( count_zeroes , count_ones ) ) ;
	 }
      }
      auto pos = std::remove_if( allPairs.begin( ) , allPairs.end( ) ,
	    []( const auto p ) { return p.first != p.second ; } ) ;
      if ( pos != allPairs.end( ) ) {
	 std::sort( allPairs.begin( ) , pos , []( const auto p1 , const auto
		  p2 ) { return p1.first > p2.first ; } ) ;
	 std::cout << (allPairs.begin( )->first + allPairs.begin( )->second ) <<
	    '\n' ;
      }
      else {
	 std::cout << 0 << '\n' ;
      }
   }
   return 0 ;
}
