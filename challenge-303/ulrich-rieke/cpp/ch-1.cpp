#include <iostream>
#include <sstream>
#include <string>
#include <algorithm>
#include <vector>
#include <set>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

int to_number( const std::vector<int> & numbers ) {
   int number = 0 ;
   int multBy = 100 ;
   for ( int i : numbers ) {
      number += i * multBy ;
      multBy /= 10 ;
   }
   return number ;
}

int main( ) {
   std::cout << "Enter at least 3 one-digit positive numbers separated by spaces!\n";
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers , sums ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::sort( numbers.begin( ) , numbers.end( ) ) ;
   do {
      std::vector<int> currentVec( numbers.begin( ) , numbers.begin( ) + 3 ) ;
      if ( currentVec[0] != 0 ) {
	 int num { to_number( currentVec ) } ;
	 if ( num % 2 == 0 ) 
	    sums.push_back( num ) ;
      }
   } while ( std::next_permutation( numbers.begin( ) , numbers.end( ) )) ;
   std::set<int> uniques( sums.begin( ) , sums.end( ) ) ;
   std::cout << '(' ;
   for ( int i : uniques ) {
      std::cout << i << ' ' ;
   }
   std::cout << ")\n" ;
   return 0 ;
}

   
