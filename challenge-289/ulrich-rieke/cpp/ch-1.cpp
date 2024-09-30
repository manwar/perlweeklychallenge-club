#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <set> 
#include <algorithm>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::string word ;
   std::istringstream istr { text } ;
   while ( std::getline( istr , word , delimiter ))
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter some integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto w : tokens ) {
      numbers.push_back( std::stoi( w ) ) ;
   }
   if ( numbers.size( ) < 3 ) 
      std::cout << *std::max_element( numbers.begin( ) , numbers.end( ) ) << 
	 '\n' ;
   else {
      std::set<int> uniques { numbers.begin( ) , numbers.end( ) } ;
      std::vector<int> for_sorting { uniques.begin( ) , uniques.end( ) } ;
      if ( for_sorting.size( ) < 3 ) {
	 std::cout << *std::max_element( for_sorting.begin( ) , for_sorting.end( ) ) 
	    << '\n' ;
      }
      else {
	 std::sort( for_sorting.begin( ) , for_sorting.end( ) , []( int a , int b) {
	       return a > b ; } ) ;
	 std::cout << *(for_sorting.begin( ) + 2 ) << '\n' ;
      }
   }
   return 0 ;
}
	 
      
   


