#include <vector>
#include <iostream>
#include <string>
#include <sstream>
#include <cstdlib>
#include <algorithm>

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
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   int positives = std::count_if( numbers.begin( ) , numbers.end( ) , [](int i) {
	 return i > 0 ; } ) ;
   int negatives = std::count_if( numbers.begin( ) , numbers.end( ) , [](int i) {
	 return i < 0 ; } ) ;
   if ( positives != 0 || negatives != 0 ) {
      std::cout << std::max( positives , negatives ) << '\n' ;
   }
   else {
      std::cout << 0 << '\n' ;
   }
   return 0 ;
}
