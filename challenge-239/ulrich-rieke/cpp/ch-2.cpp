#include <vector>
#include <string>
#include <algorithm>
#include <iostream>
#include <set>

std::set<char> toCharSet( std::string s ) {
   std::set<char> charSet ( s.begin( ) , s.end( ) ) ;
   return charSet ;
}

std::vector<std::string> split( const std::string & startline ,
      const std::string & sep ) {
   std::vector<std::string> separated ;
   std::string::size_type start { 0 } ;
   std::string::size_type pos ;
   do {
      pos = startline.find_first_of( sep , start ) ;
      separated.push_back( startline.substr(start , pos - start )) ;
      start = pos + 1 ;
   } while ( pos != std::string::npos ) ;
   return separated ;
}

int main( ) {
   std::cout << "Please enter some strings, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> allStrings( split( line , " " ) ) ;
   std::cout << "Please enter an allowed string!\n" ;
   std::string allowed ;
   std::cin >> allowed ;
   //we want to check whether the set of characters in allowed contains
   //all the characters in the character set of a given word
   //for that purpose, we convert the allowed string and all entered 
   //strings into set by calling the respective set constructor and then
   //count the number of elements that are included in the allowed character
   //set
   std::set<char> allowedSet ( allowed.begin( ) , allowed.end( ) ) ;
   std::vector<std::set<char>> allCharSets ;
   for ( auto s : allStrings ) 
      allCharSets.push_back( toCharSet( s ) ) ;
   int count = std::count_if( allCharSets.begin( ) , allCharSets.end( ) ,
	 [allowedSet]( auto s ) { return std::includes( allowedSet.begin( ),
	    allowedSet.end( ) , s.begin( ) , s.end( ) ) ; } ) ;
   std::cout << count << std::endl ;
   return 0 ;
}
