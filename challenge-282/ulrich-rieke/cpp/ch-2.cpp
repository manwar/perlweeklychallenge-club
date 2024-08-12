#include <iostream>
#include <string>
#include <cctype>
#include <algorithm>
#include <vector> 

std::string to_lower( std::string aWord ) {
   std::transform( aWord.begin( ) , aWord.end( ) , aWord.begin( ) , 
	 tolower ) ;
   return aWord ;
}

int main( ) {
   std::cout << "Please enter an alphabetic word!\n" ;
   std::string word ;
   std::cin >> word ;
   int pos = 0 ;
   std::vector<std::string> pairs ;
   while ( pos < word.length( ) - 2 ) {
      pairs.push_back( word.substr( pos , 2 ) ) ;
      pairs.push_back( word.substr( pos + 1 , 2 ) ) ;
      pos += 2 ;
   }
   std::transform( pairs.begin( ) , pairs.end( ) , pairs.begin( ) , 
	 to_lower ) ;
   std::cout << std::count_if( pairs.begin( ) , pairs.end( ) , []( const
	    auto & s ) { return s.at( 0 ) != s.at( 1 ) ; }) << '\n' ;
   return 0 ;
}
