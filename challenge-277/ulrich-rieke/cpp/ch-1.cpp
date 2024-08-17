#include <iostream>
#include <ranges>
#include <string>
#include <vector>
#include <map>
#include <algorithm>

std::vector<std::string> split( std::string text , char delim ) {
   auto parts = text | std::views::split( delim ) 
                     | std::views::transform( []( auto&& subpart ) {
			return std::string( subpart.begin( ) ,
			      subpart.end( ) ) ; }) ;
   std::vector<std::string> words ( parts.begin( ) , parts.end( ) ) ;
   return words ;
}

int main( ) {
   std::cout << "Enter some words , separated by blanks!\n" ;
   std::string firstLine , secondLine ;
   std::getline( std::cin , firstLine ) ;
   std::cout << "Enter some more words , separated by blanks!\n" ;
   std::getline( std::cin , secondLine ) ;
   std::vector<std::string> firstWords( split( firstLine , ' ' ) ) ;
   std::vector<std::string> secondWords( split( secondLine , ' ' ) ) ;
   std::vector<std::string> common_words ;
   std::ranges::sort( firstWords ) ; //intersection only on sorted containers!
   std::ranges::sort( secondWords ) ;
   std::set_intersection( firstWords.begin( ) , firstWords.end( ) , 
	 secondWords.begin( ) , secondWords.end( ) , std::back_inserter( 
	    common_words ) ) ;
   std::map<std::string , int> firstFreq , secondFreq ;
   for ( auto s : firstWords ) 
      firstFreq[s]++ ;
   for ( auto s : secondWords ) 
      secondFreq[s]++ ;
   std::cout << std::count_if( common_words.begin( ) , common_words.end( ), 
	 [&firstFreq , &secondFreq]( auto s ){ return firstFreq.find( s )
	 ->second == 1 && secondFreq.find( s )->second == 1 ; } ) << '\n' ;
   return 0 ;
}
