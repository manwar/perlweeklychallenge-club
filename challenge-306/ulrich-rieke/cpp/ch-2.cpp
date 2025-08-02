#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <algorithm>

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
   std::cout << "Enter some integers separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   while ( numbers.size( ) > 1 ) {
      std::sort( numbers.begin( ) , numbers.end( ) ) ;
      int len = numbers.size( ) ;
      if ( numbers[len - 2] == numbers[len - 1] ) {
	 numbers.pop_back( ) ;
	 numbers.pop_back( ) ;
      }
      else {
         numbers[ len - 1 ] = numbers[ len - 1 ] - numbers[ len - 2 ] ;
	 numbers.erase( numbers.begin( ) + len - 2 ) ;
      }
   }
   if ( numbers.size( ) == 1 ) {
      std::cout << *numbers.begin( ) ;
   }
   else {
      std::cout << 0 ;
   }
   std::cout << '\n' ;
   return 0 ;
}
