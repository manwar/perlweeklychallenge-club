#include <vector>
#include <iterator>
#include <cstdlib>
#include <iostream>
#include <algorithm>

int main( ) {
   std::cout << "Enter some integers, separated by whitespace!\n" ;
   std::cout << "Enter e to end entry!\n" ;
   std::vector<int> numbers { std::istream_iterator<int>{ std::cin } , 
      std::istream_iterator<int>{} } ;
   int positives = std::count_if( numbers.begin( ) , numbers.end( ) , 
	 []( int i ) { return i > 0 ; } ) ;
   int negatives = std::count_if( numbers.begin( ) , numbers.end( ) ,
	 []( int i ) { return i < 0 ; } ) ;
   std::cout << std::max( positives, negatives ) << '\n' ;
   return 0 ;
}
