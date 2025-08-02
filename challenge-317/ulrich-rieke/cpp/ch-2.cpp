#include <string>
#include <sstream>
#include <iostream>
#include <utility>
#include <vector>

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
   std::cout << "Enter 2 words separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin, line ) ;
   auto tokens { split( line , ' ' ) } ;
   if ( tokens[0].length( ) != tokens[1].length( ) ) {
      std::cout << "false\n" ;
   }
   else {
      //zip the two words letter by letter. Then look for the different
      //characters . The number of their pairs should be 2 and they should be
      //in reverse order of each other
      std::vector<std::pair<char , char>> zipped , different ;
      for ( int i = 0 ; i < tokens[0].length( ) ; i++ ) {
	 zipped.push_back( std::make_pair( tokens[0][i] , tokens[1][i] ) ) ;
      }
      for ( auto p : zipped ) {
	 if ( p.first != p.second ) 
	    different.push_back( p ) ;
      }
      std::cout << std::boolalpha << ( different.size( ) == 2 && 
	    different[0].first == different[1].second && different[0].second
	    == different[1].first ) << '\n' ;
   }
   return 0 ;
}

