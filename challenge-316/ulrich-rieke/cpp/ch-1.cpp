#include <vector>
#include <iostream>
#include <sstream>

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
   std::cout << "Enter some words separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   bool result = true ;
   int len = tokens.size( ) ;
   for ( int i = 0 ; i < len - 1 ; i++ ) {
      if ( tokens[i].substr( tokens[i].length( ) - 1 , 1 ) != 
	    tokens[i + 1].substr( 0 , 1 ) ) {
	 result = false ;
	 break ;
      }
   }
   std::cout << std::boolalpha << result << '\n' ;
   return 0 ;
}
