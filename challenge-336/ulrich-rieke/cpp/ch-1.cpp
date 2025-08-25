#include <iostream>
#include <string> 
#include <sstream>
#include <vector>
#include <utility>
#include <algorithm>
#include <set>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some numbers separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line, ' ' ) } ;
   std::string numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::set<int> uniques { numbers.begin( ) , numbers.end( ) } ;
   std::vector<std::pair<int , int>> frequencies ;
   for ( auto it = uniques.begin( ) ; it != uniques.end( ) ; ++it ) {
      frequencies.push_back( std::make_pair( *it , std::count( numbers.begin( ) , 
		  numbers.end( ) , *it ))) ;
   }
   bool result = false ;
   if ( frequencies.size( ) == 1 ) {
      result = frequencies[0].second > 1 ;
   }
   else {
      std::sort( frequencies.begin( ) , frequencies.end( ) , []( const auto & 
	       aPair , const auto & bPair ) { return aPair.second < bPair.second ; }
	    ) ;
      int mini = frequencies[0].second ;
      result = mini > 1 && std::all_of( frequencies.begin( ) + 1 , frequencies.end( ),
	    [mini]( const auto & p ) { return p.second % mini == 0 ; } ) ;
   }
   std::cout << std::boolalpha << result << '\n' ;
   return 0 ;
}
