#include <iostream>
#include <sstream>
#include <string>
#include <utility>
#include <vector>
#include <algorithm>
#include <regex>
#include <cstdlib>

std::vector<std::string> split( const std::string & text , char delimiter) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ))
      tokens.push_back( word ) ;
   return tokens ;
}

bool isValid( const std::pair<int , int> & point , const std::pair<int , 
      int> & comparison ) {
   return point.first == comparison.first || point.second == 
      comparison.second ;
}

int manhattan( const std::pair<int , int> & point , const 
      std::pair<int , int> & comparison ) {
   return std::abs( point.first - comparison.first ) + 
      std::abs( point.second - comparison.second ) ;
}

int main( ) {
   std::cout << "Enter two integers separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin, line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::cout << "Enter some points ( in brackets ) separated by blanks!\n" ;
   std::getline( std::cin , line ) ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::pair<int , int> comparison { std::make_pair( numbers[0] , 
	 numbers[1] ) } ;
   std::string pattern ( "\\d+" ) ;
   std::regex re { pattern } ;
   std::vector<int> points ;
   auto end = std::sregex_token_iterator{} ;
   for ( auto it = std::sregex_token_iterator{ std::begin( line ) , 
	    std::end( line ) , re } ; it != end ; ++it )
      points.push_back( std::stoi( *it ) ) ;
   std::vector<std::pair<int , int>> coordinates ;
   for ( int i = 0 ; i < points.size( ) - 1 ; i += 2 ) {
      coordinates.push_back( std::make_pair( points[i] , points[i + 1] ));
   }
   std::vector<std::pair<int , std::pair<int , int>>> zipped ;
   int len = coordinates.size( ) ;
   for ( int i = 0 ; i < len ; i++ ) 
      zipped.push_back( std::make_pair( i , coordinates[i] ) ) ;
   std::vector<std::pair<int , std::pair<int , int>>> selected ;
   std::copy_if( zipped.begin( ) , zipped.end( ) ,
	 std::back_inserter( selected) , 
	 [comparison](const auto & p ){ return isValid( p.second ,
	    comparison) ; }) ;
   int sz = selected.size( ) ;
   if ( sz == 0 ) {
      std::cout << -1 ;
   }
   if ( sz == 1 ) {
      std::cout << selected[0].first ;
   }
   if ( sz > 1 ) {
      std::sort( selected.begin( ) , selected.end( ) , [comparison](
	       const auto & p1 , const auto & p2 ) { if ( manhattan( 
		     p1.second , comparison ) != manhattan( p2.second , 
			comparison )) {
	    return manhattan(p1.second , comparison ) < manhattan( 
		  p2.second , comparison ) ;
	    }
	    else {
	       return p1.first < p2.first ;
	       } } ) ;
      std::cout << selected[0].first ;
   }
   std::cout << '\n' ;
   return 0 ;
}
