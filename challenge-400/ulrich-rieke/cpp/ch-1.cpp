#include <iostream>
#include <vector>
#include <set>
#include <numeric>
#include <algorithm>

bool isRepeating( int number ) {
   if ( number > 9 ) {
      std::vector<int> digits ;
      while ( number != 0 ) {
         digits.push_back( number % 10 ) ;
         number /= 10 ;
      }
      std::set<int> uniques( digits.begin( ) , digits.end( ) ) ;
      return uniques.size( ) != digits.size( ) ;
   }
   else {
      return false ;
   }
}

int main( ) {
   std::cout << "Enter a positive integer!\n" ;
   int number ;
   std::cin >> number ;
   std::vector<int> selected ;
   for ( int i = 1 ; i < number + 1 ; i++ ) {
      if ( ! isRepeating( i ) ) {
         selected.push_back( i ) ;
      }
   }
   std::adjacent_difference( selected.begin( ) , selected.end( ) , 
         selected.begin( ) ) ;
   std::cout << *std::max_element( selected.begin( ) + 1 , selected.end( ) ) 
      << '\n' ;
   return 0 ;
}

