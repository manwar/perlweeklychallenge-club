#include <iostream>
#include <sstream>
#include <vector>
#include <algorithm>
#include <utility>

std::vector<std::string> split( const std::string & text , const char
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter an even number of positive integers!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::vector<std::pair<int , int>> pairs , selected ;
   int pos = 0 ;
   while ( pos < numbers.size( ) - 1 ) {
      pairs.push_back( std::make_pair( numbers[pos] , numbers[pos + 1] ));
      pos += 2 ;
   }
   std::sort( pairs.begin( ) , pairs.end( ) , []( const auto p1 , const 
            auto p2 ) { return p1.first < p2.first ; } ) ;
   selected.push_back( pairs[0] ) ;
   for ( auto it = pairs.begin( ) + 1 ; it != pairs.end( ) ; ++it ) {
      if ( it->first > selected.back().first && it->second > 
            selected.back( ).second ) {
         selected.push_back( *it ) ;
      }
   }
   std::cout << static_cast<int>( selected.size( ) ) << '\n' ;
   return 0 ;
}
