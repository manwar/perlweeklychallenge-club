#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <sstream>
#include <cmath>
#include <numeric>

std::vector<std::string> split( const std::string &text , const char
      delimiter ) {
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
   double average = std::accumulate( numbers.begin( ) , numbers.end( ) , 0 ) /
      static_cast<double>( numbers.size( ) ) ;
   double ceiling { std::ceil( average ) } ;
   int current { 0 } ;
   if ( ceiling == average ) {
      current = static_cast<int>( average ) + 1 ;
   }
   else {
      current = static_cast<int>( ceiling ) ;
   }
   while ( current <= 0 ) {
      current++ ;
   }
   while ( std::find( numbers.begin( ) , numbers.end( ) , current ) != 
         numbers.end( ) ) {
      current++ ;
   }
   std::cout << current << '\n' ;
   return 0 ;
}
