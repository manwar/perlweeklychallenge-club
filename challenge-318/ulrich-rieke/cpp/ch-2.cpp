#include <vector>
#include <utility>
#include <map>
#include <sstream>
#include <vector>
#include <iostream>
#include <algorithm>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

bool isAscending( const std::vector<int> &numbers ) {
   int len = numbers.size( ) ;
   for ( int i = 0 ; i < len - 1 ; i++ ) {
      if ( numbers[ i + 1 ] - numbers[ i ] != 1 ) {
	 return false ;
      }
   }
   return true ;
}

int main( ) {
   std::cout << "Enter some integers separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<int> firstnums , secondnums ;
   auto firsttokens { split( line , ' ' ) } ; 
   for ( auto s : firsttokens ) 
      firstnums.push_back( std::stoi( s ) ) ;
   std::cout << "Enter the same integers in a different order!\n" ;
   line.clear( ) ;
   std::getline( std::cin , line ) ;
   auto secondtokens { split( line , ' ' ) } ;
   for ( auto s : secondtokens ) 
      secondnums.push_back( std::stoi( s ) ) ;
   if ( firstnums.size( ) == 1 && secondnums.size( ) == 1 ) {
      std::cout << "true\n" ;
   }
   else {
      std::vector<std::pair<int , int>> positions ;
      for ( int i = 0 ; i < firstnums.size( ) ; i++ ) {
	 positions.push_back( std::make_pair( i , i + static_cast<int>(
	  std::distance( secondnums.begin( ) , std::find( secondnums.begin( ) ,
		secondnums.end( ) , firstnums[i] ) )))) ;
      }
      std::map<int , std::vector<int>> sums ;
      for ( auto p : positions ) {
	 sums[p.second].push_back( p.first ) ;
      }
      std::vector<std::pair<int , std::vector<int>>> sumpositions { sums.begin( ) ,
	 sums.end( ) } ;
      std::cout << std::boolalpha << ( std::count_if ( sumpositions.begin( ) , 
	       sumpositions.end( ) , []( const auto & p ) { return p.second.size( )
	       > 1 && isAscending( p.second ) ; } ) == 1 ) << '\n' ;
   }
   return 0 ;
}












