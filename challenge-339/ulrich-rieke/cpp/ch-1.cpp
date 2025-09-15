#include <vector>
#include <iostream>
#include <sstream>
#include <string>
#include <algorithm>
#include <cstdlib>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter at least 4 integers separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   int len = numbers.size( ) ;
   //if all numbers are positive or 0 or all are negative , we sort in 
   //ascending order. In the first case, we subtract the product of the 
   //two greatest numbers from the product of the 2 smallest. In the other
   //case , vice versa.
   //if the numbers are both positive and negative , we sort in ascending
   //order of absolute values
   bool allPositive = std::all_of( numbers.begin( ) , numbers.end( ) , []( int
	    d ) {return d >= 0 ; } ) ;
   bool allNegative = std::all_of ( numbers.begin( ) , numbers.end( ) , [](
	    int d ) { return d < 0 ; } ) ;
   if ( allPositive || allNegative ) {
      std::sort( numbers.begin( ) , numbers.end( )) ;
      if ( allPositive ) {
	 std::cout << ( numbers[len - 2] * numbers[len - 1] - numbers[0] * 
	       numbers[1] ) << '\n' ;
      }
      if ( allNegative ) {
	 std::cout << ( numbers[0] * numbers[1] - numbers[len - 2] * numbers[len
	       - 1] ) << '\n' ;
      }
   }
   else {
      std::sort( numbers.begin( ) , numbers.end( ) , [](int a , int b) {
	    return std::abs( a ) < std::abs( b ) ; } ) ;
      std::cout << ( numbers[0] * numbers[1] - numbers[len - 2] * numbers[len 
	    - 1]) << '\n' ;
   }
   return 0 ;
}


