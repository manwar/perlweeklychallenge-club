#include <iostream>
#include <vector>
#include <set>
#include <iterator>
#include <algorithm> 

int main( ) {
   std::cout << "Enter some integers, separated by blanks, e to end!\n" ;
   std::vector<int> numbers {std::istream_iterator<int>{std::cin} , 
      std::istream_iterator<int>{}} ;
   std::set<int> uniques( numbers.begin( ) , numbers.end( ) );
   std::vector<int> frequencies ;
   for ( auto i : uniques ) {
      frequencies.push_back( std::count( numbers.begin( ) ,
	       numbers.end( ) , i ) ) ;
   }
   std::set<int> allFreq ( frequencies.begin( ) , frequencies.end( ) ) ;
   if ( uniques.size( ) == allFreq.size( ) ) {
      std::cout << 1 << '\n' ;
   }
   else {
      std::cout << 0 << '\n' ;
   }
   return 0 ;
}

