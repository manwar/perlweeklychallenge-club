#include <iostream>
#include <string>
#include <algorithm>
#include <sstream>
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
   std::cout << "Enter some words separated by blanks!\n" ;
   std::string line ; 
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<char> vowels { 'a' , 'e' , 'i' , 'o' , 'u' , 'A' , 'E' , 'I' , 
      'O' , 'U' } ;
   std::cout << std::count_if( tokens.begin( ) , tokens.end( ) , [vowels]( 
	    auto & s ) { return std::find( vowels.begin( ) , vowels.end( ) ,
	       s[0] ) != vowels.end( ) || std::find( vowels.begin( ) , 
		  vowels.end( ) , s[s.length( ) - 1]) != vowels.end( ) ; } ) 
      << '\n' ;
   return 0 ;
}
