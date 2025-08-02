#include <vector>
#include <string>
#include <sstream>
#include <iostream>
#include <algorithm>
#include <cstdlib>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::string word ;
   std::istringstream istr { text } ;
   while ( std::getline( istr , word , delimiter ))
      tokens.push_back( word ) ;
   return tokens ;
}

std::vector<std::vector<int>> findCombinations( const std::vector<int> & 
      numbers ) {
   std::vector<std::vector<int>> combis ;
   int len = numbers.size( ) ;
   for ( int i = 0 ; i < len - 1 ; i++ ) {
      std::vector<int> aCombi ;
      aCombi.push_back( numbers[ i ] ) ;
      for ( int j = i + 1 ; j < len ; j++ ) {
	 aCombi.push_back( numbers[ j ] ) ;
	 combis.push_back( aCombi ) ;
	 aCombi.erase( aCombi.begin( ) + 1 ) ;
      }
   }
   return combis ;
}

int main( ) {
   std::cout << "Enter some distinct integers separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   auto allCombis { findCombinations( numbers ) } ;
   std::vector<int> differences ;
   for ( auto vec : allCombis ) {
      differences.push_back( std::abs( vec[0] - vec[1] ) ) ;
   }
   int minimum = *std::min_element( differences.begin( ) , differences.end( ) ) ;
   for ( auto vec : allCombis ) {
      if ( std::abs( vec[0] - vec[1] ) == minimum ) {
	 std::cout << '[' << vec[0] << ',' << vec[1] << "] " ;
      }
   }
   std::cout << '\n' ;
   return 0 ;
}
