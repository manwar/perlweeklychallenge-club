#include <string>
#include <vector>
#include <iostream>
#include <sstream>
#include <cctype>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter a string with some words separated by space!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::string result ;
   for ( auto s : tokens ) {
      if ( s.length( ) < 3 ) {
	 for ( auto c : s ) {
	    result.push_back( std::tolower( c ) ) ;
	 }
      }
      else {
	 for ( auto c : s ) {
	    if ( c == s[0] ) {
	       result.push_back( std::toupper( c ) ) ;
	    }
	    else {
	       result.push_back( std::tolower( c ) ) ;
	    }
	 }
      }
      result.push_back( ' ' ) ;
   }
   result.pop_back( ) ;
   std::cout << result << '\n' ;
   return 0 ;
}


	 
