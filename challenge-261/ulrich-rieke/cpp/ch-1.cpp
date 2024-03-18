#include <iostream>
#include <numeric>
#include <vector>
#include <iterator>
#include <cstdlib>

int digitsum( int n ) {
   int sum = 0 ;
   while ( n != 0 ) {
      sum += n % 10 ;
      n /= 10 ;
   }
   return sum ;
}

int main( ) {
   std::cout << "Enter some integers, separated by blanks!\n" ;
   std::cout << "Enter e to end!\n" ;
   std::vector<int> numbers {std::istream_iterator<int>{std::cin} , 
      std::istream_iterator<int>{}} ;
   int element_sum = std::accumulate( numbers.begin( ) , numbers.end( ) ,
	 0 ) ;
   std::vector<int> digitsums ;
   for ( int i : numbers ) 
      digitsums.push_back( digitsum( i ) ) ;
   int total_digitsums = std::accumulate( digitsums.begin( ) , 
	 digitsums.end( ) , 0 ) ;
   std::cout << std::abs( total_digitsums - element_sum) << '\n' ;
   return 0 ;
}
