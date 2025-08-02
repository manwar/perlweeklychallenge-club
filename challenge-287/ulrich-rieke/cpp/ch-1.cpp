#include <iostream>
#include <string>
#include <regex>
#include <vector>
#include <numeric>

int main( ) {
   std::cout << "Enter a password!\n" ;
   std::string word ;
   std::cin >> word ;
   int totalsteps = 0 ;
   const std::regex rgx1("[a-z]") ;
   const std::regex rgx2("[A-Z]") ;
   const std::regex rgx3("\\d") ;
   int len = word.length( ) ;
   if ( len < 6 ) {
      totalsteps += 6 - len ;
   }
   //beware : it took me quite some time to find out that 
   //std::regex_match does not return the right result!!
   //if you want to check whether a given regular expression
   //such as \d matches I had to use std::regex_search!!!
   if ( ! std::regex_search( word , rgx1 )) {
      if ( len >= 6 ) {
	 totalsteps++ ;
      }
   }
   if ( ! std::regex_search( word , rgx2 )) {
      if ( len >= 6 ) {
	 totalsteps++ ;
      }
   }
   if ( ! std::regex_search( word , rgx3 )) {
      if ( len >= 6 ) {
	 totalsteps++ ;
      }
   }
   //std::regex appears not to allow backreferences...?
   //so, to prevent too many identical neighbouring letters
   //I group the letters , divide their lengths by 3 and sum the
   //quotients up ( inspired by Haskell where this operation is so easy
   //to perform!!!
   std::vector<std::string> neighbouring_letters ;
   std::string currentWord ;
   //imitate Haskell's group function!
   for ( auto it = word.begin( ) ; it != word.end( ) ; ++it ) {
      if ( currentWord.empty( ) ) 
	 currentWord.push_back( *it ) ;
      else {
	 char last_char = currentWord.back( ) ;
	 if ( last_char == *it ) {
	    currentWord.push_back( *it ) ;
	 }
	 else {
	    neighbouring_letters.push_back( currentWord ) ;
	    currentWord.clear( ) ;
	    currentWord.push_back( *it ) ;
	 }
      }
   }
   neighbouring_letters.push_back( currentWord ) ;
   std::vector<int> grouplengths ;
   for ( auto v : neighbouring_letters ) {
      grouplengths.push_back( v.length( ) / 3 ) ;
   }
   int replacements = std::accumulate( grouplengths.begin( ) , 
	 grouplengths.end( ) , 0 ) ;
   totalsteps += replacements ;
   std::cout << totalsteps << '\n' ;
   return 0 ;
}
