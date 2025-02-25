#include <string>
#include <sstream>
#include <vector>
#include <iostream>

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
   std::cout << "Enter some integers in ascending order separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   int len = numbers.size( ) ;
   int min_diff = numbers[1] - numbers[0] ;
   int gap_end = numbers[1] ;
   for ( int pos = 2 ; pos < len ; pos++ ) {
      int current_diff = numbers[ pos ] - numbers[ pos - 1] ;
      if ( current_diff < min_diff ) {
	 min_diff = current_diff ;
	 gap_end = numbers[ pos ] ;
      }
   }
   std::cout << gap_end << '\n' ;
   return 0 ;
}
