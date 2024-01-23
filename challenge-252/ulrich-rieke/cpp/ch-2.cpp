#include <vector>
#include <iostream>
#include <algorithm>
#include <iterator>
#include <numeric>

int main( ) {
   std::cout << "Enter a positive integer!\n" ;
   int number ;
   std::cin >> number ;
   int limit = number / 2 ;
   int neg_limit = -limit ;
   std::vector<int> solution ;
   if ( number % 2 == 1 ) {
      solution.reserve( number ) ;
      std::iota( solution.begin( ) , solution.end( ) , neg_limit ) ;
   }
   else {
      int current = neg_limit ;
      for ( int i = 0 ; i < number - 1 ; i++ ) {
	 solution.push_back( current ) ;
	 current++ ;
      }
      int sum = std::accumulate( solution.begin( ) , solution.end( ) , 
	0 ) ;    
      solution.push_back( 0 - sum ) ;
   }
   std::cout << '(' ;
   std::copy( solution.begin( ) , solution.end( ) , 
	 std::ostream_iterator<int>( std::cout , " " )) ;
   std::cout << ")\n" ;
   return 0 ;
}
