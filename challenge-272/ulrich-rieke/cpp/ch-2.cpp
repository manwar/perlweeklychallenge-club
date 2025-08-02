#include <vector>
#include <string>
#include <iostream>
#include <algorithm>
#include <numeric>
#include <cstdlib>

int main( ) {
   std::cout << "Please enter a word!\n" ;
   std::string word ;
   std::cin >> word ;
   int len = word.length( ) ;
   std::vector<int> numbers( len ) ;
   std::transform( word.begin( ) , word.end( ) , numbers.begin( ) , 
	 []( char c ) { return static_cast<int>( c ) ; } ) ;
   std::vector<int> differences( len ) ;
   std::adjacent_difference( numbers.begin( ) , numbers.end( ) , 
	 differences.begin( ) ) ;
   std::transform( differences.begin( ) , differences.end( ) , 
	 differences.begin( ) , []( int i ) { return std::abs( i ) ; } ) ;
   //according to the algorithm adjacent_difference, the first element
   //is copied unchanged, everything from element 2 is a difference 
   std::cout << std::accumulate( differences.begin( ) + 1 , 
	 differences.end( ) , 0 ) << '\n' ;
   return 0 ;
}
