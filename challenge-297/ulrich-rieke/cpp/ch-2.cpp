#include <string>
#include <iostream>
#include <sstream>
#include <vector>
#include <iterator>
#include <numeric>
#include <algorithm>

std::vector<std::string> split( const std::string & text , char delim ) {
   std::istringstream istr { text } ;
   std::vector<std::string> tokens ;
   std::string word ;
   while ( std::getline( istr , word , delim ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

int main( ) {
   std::cout << "Enter some unique integers separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens )
      numbers.push_back( std::stoi( s ) ) ;
   int mini = *std::min_element( numbers.begin( ) , numbers.end( ) ) ;
   int maxi = *std::max_element( numbers.begin( ) , numbers.end( ) ) ;
   auto minpos = std::find( numbers.begin( ) , numbers.end( ) , mini ) ;
   auto maxpos = std::find( numbers.begin( ) , numbers.end( ) , maxi ) ;
   int minsteps = static_cast<int>( std::distance( numbers.begin( ) , minpos ) ) ;
   int maxsteps = static_cast<int>( std::distance( numbers.begin( ) , maxpos )) ;
   if ( minsteps < maxsteps ) {
      std::cout << minsteps + numbers.size( ) - 1 - maxsteps << '\n' ;
   }
   else {
      std::cout << minsteps + numbers.size( ) - 1 - maxsteps - 1 << '\n' ;
   }
   return 0 ;
}
