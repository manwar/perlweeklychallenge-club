#include <iostream>
#include <string>
#include <sstream>
#include <numeric>
#include <vector>
#include <cmath>

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
   std::cout << "Enter some positive integers!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto w : tokens ) 
      numbers.push_back( std::stoi( w ) ) ;
   std::vector<int> selected ;
   for ( int i : numbers ) {
      if ( i % 2 == 0 && i % 3 == 0 ) 
         selected.push_back( i ) ;
   }
   if (selected.size( ) == 0) {
      std::cout << 0 << '\n' ;
   }
   else {
      double average = std::accumulate( selected.begin( ) , selected.end( ) ,
            0 ) / static_cast<double>( selected.size( ) ) ;
      std::cout << std::round( average ) << '\n' ;
   }
   return 0 ;
}
