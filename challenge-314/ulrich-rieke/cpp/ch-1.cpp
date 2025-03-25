#include <string>
#include <sstream>
#include <vector>
#include <algorithm>
#include <iostream>
#include <numeric>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

int main( ) {
   std::cout << "Enter 3 words separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<std::string> firstLetters ;
   for ( auto w : tokens ) 
      firstLetters.push_back( w.substr( 0 , 1 ) ) ;
   auto first = firstLetters[0] ;
   if ( ! std::all_of( firstLetters.begin( ) , firstLetters.end( ) , [first](
	       auto const & s ) { return s == first ; } ) ) 
      std::cout << -1 << '\n' ;
   else {
      std::vector<std::string> wordstarts ;
      std::vector<int> lengths ;
      for ( auto w : tokens ) {
	 lengths.push_back( w.length( ) ) ;
      }
      int shortest = *std::min_element( lengths.begin( ) , lengths.end( ) ) ;
      for ( int i = 1 ; i < shortest + 1 ; i++ ) { 
	 std::vector<std::string> starts ;
	 for ( auto w : tokens ) {
	    starts.push_back( w.substr( 0 , i ) ) ;
	 }
	 std::string comparison { starts[0] } ;
	 if ( std::all_of( starts.begin( ) , starts.end( ) , [comparison]( const
		     auto & w ) { return w == comparison ; } ) ) {
	    wordstarts.push_back( comparison ) ;
	 }
      }
      int longestCommonSublen = 0 ;
      for ( auto w : wordstarts ) {
	 if ( w.length( ) > longestCommonSublen ) {
	    longestCommonSublen = w.length( ) ;
	 }
      }
      std::vector<int> remainingLengths ;
      for ( auto w : tokens ) 
	 remainingLengths.push_back( w.length( ) - longestCommonSublen ) ;
      std::cout << std::accumulate( remainingLengths.begin( ) , 
	    remainingLengths.end( ) , 0 ) << '\n' ;
   }
   return 0 ;
}
