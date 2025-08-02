#include <string>
#include <iostream>
#include <vector>
#include <regex>
#include <cctype>
#include <algorithm>

int main( ) {
   std::cout << "Enter a string!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::regex rx ( "\\S+" ) ;
   std::vector<std::string> words ;
   auto end = std::sregex_token_iterator {} ;
   for ( auto it = std::sregex_token_iterator( std::begin( line ) , 
	    std::end( line ) , rx ) ; it != end ; it++ ) {
      words.push_back( *it ) ;
   }
   std::vector<std::string> selected ;
   for ( auto s : words ) {
      if ( std::all_of( s.begin( ) , s.end( ) , []( auto c ){ return 
	       std::isalnum( c ) ; } ) )
	 selected.push_back( s ) ;
   }  
   int len = static_cast<int>( selected.size( ) ) ;
   std::cout << selected[len - 1].size( ) << '\n' ;
   return 0 ;
}
