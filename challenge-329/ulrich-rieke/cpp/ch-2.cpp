#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <cctype>

bool isNice(const std::string & word ) {
   auto condition = [word]( const char letter  ) {
      if ( std::isupper( static_cast<int>( letter ) ) ) {
	 return word.find( std::tolower( static_cast<int>(letter) )) != 
	    std::string::npos ;
      }
      else {
	 return word.find( std::toupper( static_cast<int>(letter))) != 
	    std::string::npos ;
      }
   } ;
   return std::all_of( word.begin( ) , word.end( ) , condition ) ;
}

int main( ) {
   std::cout << "Enter a word with uppercase and lowercase English letters only!\n" ;
   std::string word ;
   std::cin >> word ;
   std::vector<std::string> substrings ;
   int len = static_cast<int>(word.length( )) ;
   for ( int start = 0 ; start < len - 1 ; start++ ) {
      for ( int end = start + 1 ; end < len ; end++ ) {
	 substrings.push_back( word.substr( start , end - start + 1 ) ) ;
      }
   }
   std::vector<std::string> selected ;
   for ( auto s : substrings ) {
      if ( isNice( s ) ) 
	 selected.push_back( s ) ;
   }
   if ( selected.size( ) > 0 ) {
      std::sort( selected.begin( ) , selected.end( ) , []( const auto & a , const 
	       auto &b ) { return a.length( ) > b.length( ) ; } ) ;
      std::cout << selected[0] << '\n' ;
   }
   else {
      std::cout << "\"\"" << '\n' ;

   }
   return 0 ;
}
