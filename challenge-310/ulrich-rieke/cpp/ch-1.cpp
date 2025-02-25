#include <vector>
#include <string>
#include <sstream>
#include <iostream>
#include <algorithm>
#include <numeric>

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
   std::cout << "Enter some integers separated by blanks!\n" ;
   std::cout << "Enter <return> to end data entry!\n" ;
   std::string line ;
   std::vector<std::vector<int>> numberarray ;
   std::getline( std::cin , line ) ;
   while ( line.length( ) > 0 ) {
      std::vector<int> numbers ;
      auto tokens { split( line , ' ' ) } ;
      for ( auto s : tokens ) 
	 numbers.push_back( std::stoi( s ) ) ;
      numberarray.push_back( numbers ) ;
      std::getline( std::cin , line ) ;
   }
   //for the algorithm set_intersection to work the vectors have to be sorted!
   for ( auto it = numberarray.begin( ) ; it != numberarray.end( ) ; ++it ) {
      std::sort( it->begin( ) , it->end( ) ) ;
   }
   //independent lambda expression for the fold-like function accumulate
   auto find_intersection = []( std::vector<int> first , std::vector<int> second ) {
      std::vector<int> joint ;
      std::set_intersection( first.begin( ) , first.end( ) , second.begin( ) , 
	    second.end( ), std::inserter( joint , joint.begin( ) ) ) ;
      return joint ;
   } ;
   auto common = std::accumulate( numberarray.begin( ) + 1 , numberarray.end( ) , 
	 *numberarray.begin( ) , find_intersection ) ; 
   std::cout << "( " ;
   for ( int i : common ) 
      std::cout << i << ' ' ;
   std::cout << ")\n" ;
   return 0 ;
}
