#include <vector>
#include <iostream>
#include <sstream>
#include <string>
#include <numeric>
#include <set>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::string word ;
   std::istringstream istr { text } ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some numbers , their total number must be even!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<double> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stod( s ) ) ;
   std::set<double> averages ;
   while ( numbers.size( ) > 0 ) {
      auto maxpos = std::max_element( numbers.begin( ) , numbers.end( ) ) ;
      auto maxi = *maxpos ;
      numbers.erase( maxpos ) ;
      auto minpos = std::min_element( numbers.begin( ) , numbers.end( ) ) ;
      auto mini = *minpos ;
      numbers.erase( minpos ) ;
      double average = ( maxi + mini ) / 2.0 ;
      averages.insert( average ) ;
   }
   std::cout << averages.size( ) << '\n' ;
   return 0 ;
}
