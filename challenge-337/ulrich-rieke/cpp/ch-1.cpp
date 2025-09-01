#include <vector>
#include <string>
#include <sstream>
#include <algorithm>
#include <iostream>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some integers separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers , solution ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   for ( int i = 0 ; i < numbers.size( ) ; i++ ) {
      int comp = numbers[i] ;
      int c = std::count_if( numbers.begin( ) , numbers.end( ) , [comp](int n) {
	    return n <= comp ; }) ;
      if ( c > 0 ) 
	 solution.push_back( c - 1 ) ;
      else
	 solution.push_back( 0 ) ;
   }
   std::cout << "( " ;
   for ( int i : solution ) 
      std::cout << i << ' ' ;
   std::cout << ")\n" ;
   return 0 ;
}
