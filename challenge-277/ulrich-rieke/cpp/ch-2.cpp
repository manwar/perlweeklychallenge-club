#include <iostream>
#include <iterator>
#include <vector>
#include <utility>
#include <set>
#include <algorithm>
#include <cstdlib> // for abs
#include <limits>  // for min

bool condition( const std::pair<int , int> & p ) {
   int diff = std::abs( p.first - p.second ) ;
   int mini = std::min( p.first , p.second ) ;
   return ( 0 < diff && ( diff < mini ) ) ;
}

int main( ) {
   std::cout << "Enter some integers, separated by blanks!\n" ;
   std::cout << "Enter e to end!\n" ;
   std::vector<int> numbers { std::istream_iterator<int>( std::cin ) , 
      std::istream_iterator<int>( ) } ;
   std::vector<std::pair<int , int>> combinations , selected ;
   int len = numbers.size( ) ;
   for ( int i = 0 ; i < len - 1 ; i++ ) {
      for ( int j = i + 1 ; j < len ; j++ ) {
	 combinations.push_back( std::make_pair( numbers[i] , 
		  numbers[j] )) ;
      }
   }
   std::copy_if( combinations.begin( ) , combinations.end( ) , 
	 std::back_inserter( selected ) , condition ) ;
   //by creating a set from the vector selected that contains the pairs
   //fulfilling the condition we remove duplicates
   std::set<std::pair<int , int>> uniques ( selected.begin( ) , 
	 selected.end( ) ) ;
   std::cout << uniques.size( ) << '\n' ;
   return 0 ;
}
