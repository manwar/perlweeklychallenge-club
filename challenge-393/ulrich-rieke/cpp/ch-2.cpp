#include <iostream>
#include <string>
#include <cmath> //std::floor , std::sqrt
#include <algorithm> //std::all_of
#include <numeric> // std::iota
#include <vector>
#include <limits>  //std::min

bool isPrime( int number ) {
   bool prime = false ;
   if ( number == 0 || number == 1 ) {
   }
   else {
      if ( number == 2 ) {
         prime = true ;
      }
      else {
         int root = static_cast<int>(std::floor( std::sqrt( static_cast<double>
                     ( number )))) ;
         std::vector<int> numbers( root - 1 ) ;
         std::iota( numbers.begin( ) , numbers.end( ) , 2 ) ;
         prime = std::all_of( numbers.begin( ) , numbers.end( ) , [number](
                  const int n ) { return number % n != 0 ; } ) ;
      }
   }
   return prime ;
}

int main( ) {
   std::cout << "Enter a word consisting of English alphabetic characters only!\n" ;
   std::string word ;
   std::cin >> word ;
   int total = 0 ;
   for ( auto c : word ) {
      total += static_cast<int>( c ) ;
   }
   if ( isPrime( total ) ) {
      std::cout << 0 << '\n' ;
   }
   else {
      int upperPrime = 0 ;
      int lowerPrime = 0 ;
      int current { total + 1 } ;
      while ( ! isPrime( current ) ) 
         current++ ;
      upperPrime = current ;
      current = total - 1 ;
      while ( ! isPrime( current ) ) 
         current-- ;
      lowerPrime = current ;
      std::cout << std::min( upperPrime - total , total - lowerPrime ) << '\n' ;
   }
   return 0 ;
}
