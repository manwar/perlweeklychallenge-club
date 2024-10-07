#include <iostream>
#include <string>
#include <sstream>
#include <vector>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter )) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

int main( ) {
   std::cout << "Enter some integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto v : tokens ) 
      numbers.push_back( std::stoi( v ) ) ;
   int len = numbers.size( ) ;
   bool result = false ;
   for ( int i = 0 ; i < len - 1 ; i++ ) {
      if ( numbers[i] > 1 ) {
	 for ( int j = i + 1 ; j < len ; j++ ) {
	    if ( numbers[i] == 2 * numbers[j] ) {
	       result = true ;
	       break ;
	    }
	 }
      }
   }
   std::cout << std::boolalpha << result << '\n' ;
   return 0 ;
}

