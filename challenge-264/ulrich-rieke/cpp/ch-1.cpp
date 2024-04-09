#include <iostream>
#include <cctype>
#include <string>
#include <algorithm>
#include <vector>

int main( ) {
   std::cout << "Enter a word!\n" ;
   std::string word ;
   std::cin >> word ;
   std::vector<char> uppers ;
   std::copy_if( word.begin( ) , word.end( ) , std::back_inserter( 
    uppers ) , []( char c ) {return std::isupper( c ) ; } ) ;
   if ( uppers.size( ) > 0 ) {
      std::vector<char> selected ;
      for ( auto it = uppers.begin( ) ; it != uppers.end( ) ; it++ ) {
	 if ( word.find( std::tolower( *it ) ) != std::string::npos ) {
	    selected.push_back( *it ) ;
	 }
      }
      if ( selected.size( ) > 0 ) {
	 std::sort( selected.begin( ) , selected.end( ) , []( char a , 
		  char b ) { return a > b ; } ) ;
	 std::cout << selected[0] << '\n' ;
      }
      else {
	 std::cout << "''\n" ;
      }
   }
   else {
      std::cout << "''\n" ;
   }
   return 0 ;
}
