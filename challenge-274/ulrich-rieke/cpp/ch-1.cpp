#include <iostream>
#include <vector>
#include <ranges>
#include <string>
#include <utility>
#include <algorithm>
#include <iterator>

std::string convert( std::pair<int , std::string> & aPair ) {
   std::string vowels {"AEIOUaeiou"} ;
   std::string word { aPair.second } ;
   std::string changed ;
   if (vowels.find( word.substr( 0 , 1 ) ) != std::string::npos) {
      changed = word + std::string( "ma" )  ;
   }
   else {
      changed = word.substr( 1 ) + word.substr( 0 , 1 ) + std::string( "ma" ) ;
   }
   for ( int i = 0 ; i < aPair.first + 2 ; i++ ) 
      changed.append( 1 , 'a' ) ;
   return changed ;
}

int main( ) {
   std::cout << "Enter a sentence!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto parts = line | std::views::split( ' ' )
                     | std::views::transform( []( auto&& subrange )
                       { return std::string( subrange.begin( ) , subrange.end( ) ) ; }
		       ) ;
   std::vector<std::string> words ( parts.begin( ) , parts.end( ) ) ;
   std::vector<std::pair<int , std::string>> allPairs ;
   for ( int i = 0 ; i < words.size( ) ; i++ ) 
      allPairs.push_back( std::make_pair( i , words[ i ] ) ) ;
   std::vector<std::string> converted ;
   for ( auto & pa : allPairs ) 
      converted.push_back( convert( pa ) ) ;
   std::copy( converted.begin( ) , converted.end( ) ,
	 std::ostream_iterator<std::string>( std::cout , " " ) ) ;
   std::cout << '\n' ;
   return 0 ;
}
