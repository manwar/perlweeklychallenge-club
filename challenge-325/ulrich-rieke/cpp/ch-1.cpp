#include <iostream>
#include <string>
#include <sstream>
#include <algorithm>
#include <vector>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::string word ;
   std::istringstream istr { text } ;
   while ( std::getline( istr , word , delimiter ))
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some 0 and 1 separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   int ones = 0 ;
   std::vector<int> groups ;
   for ( auto it = numbers.begin( ) ; it != numbers.end( ) ; ++it ) {
      if ( *it == 1 ) 
	 ones++ ;
      else {
	 if ( ones > 0 ) {
	    groups.push_back( ones ) ;
	    ones = 0 ;
	 }
      }
      if ( ones > 0 ) 
	 groups.push_back( ones ) ;
   }
   if ( groups.size( ) > 0 ) {
      std::cout << *std::max_element( groups.begin( ) , groups.end( ) ) ;
   }
   else {
      std::cout << 0 ;
   }
   std::cout << '\n' ;
   return 0 ;
}

      
