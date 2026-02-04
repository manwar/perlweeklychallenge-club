#include <iostream>
#include <vector>
#include <utility>
#include <numeric>

std::pair<int , int> findPair( int number ) {
   if ( number < 10 ) {
      return std::make_pair( 0 , number ) ;
   }
   else {
      int root = number ;
      int persistence = 0 ;
      while ( root > 9 ) {
         std::vector<int> digits ;
         while ( root != 0 ) {
            digits.push_back( root % 10 ) ;
            root /= 10 ;
         }
         persistence++ ;
         root = std::accumulate( digits.begin( ) , digits.end( ) , 0 ) ;
      }
      return std::make_pair( persistence , root ) ;
   }
}

int main( ) {
   std::cout << "Enter a positive integer!\n" ;
   int number ;
   std::cin >> number ;
   auto result { findPair( number ) } ;
   std::cout << "Persistence  = " << result.first << '\n' ;
   std::cout << "Digital root = " << result.second << '\n' ;
   return 0 ;
}

