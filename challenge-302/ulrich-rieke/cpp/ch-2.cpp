#include <string>
#include <iostream>
#include <sstream>
#include <algorithm>
#include <vector>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream instr { text } ;
   std::string word ;
   while ( std::getline( instr , word , delimiter ) ) {
      if ( word.length( ) > 0 ) {
	 tokens.push_back( word ) ;
      }
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
   int len = static_cast<int>( numbers.size( ) ) ;
   std::vector<int> partial_sums ;
   int current = numbers[0] + numbers[1] ;
   partial_sums.push_back( current ) ;
   if ( len > 2 ) {
      for ( int pos = 2 ; pos < len ; pos++ ) {
	 current += numbers[ pos ] ;
	 partial_sums.push_back( current ) ;
      }
   }
   int mini = *std::min_element( partial_sums.begin( ) ,
	 partial_sums.end( ) ) ;
   int result = 1 - mini ;
   if ( result <= 0 ) 
      std::cout << 1 << '\n' ;
   else 
      std::cout << result << '\n' ;
   return 0 ;
}
