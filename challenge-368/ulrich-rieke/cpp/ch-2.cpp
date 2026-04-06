#include <iostream>
#include <vector>
#include <set>

//finding the prime factors means: keep dividing a number by its smallest
//divisor which is a prime number

int findFactors( int number , int mode ) {
   std::vector<int> primefactors ;
   int divisor = 2 ;
   while ( number != 1 ) {
      if ( number % divisor == 0 ) {
         primefactors.push_back( divisor ) ;
         number /= divisor ;
      }
      else {
         divisor++ ;
      }
   }
   if ( mode == 0 ) {
      std::set<int> uniques { primefactors.begin( ) , primefactors.end( ) } ;
      return uniques.size( ) ;
   }
   else {
      return primefactors.size( ) ;
   }
}

int main( ) {
   std::cout << "Enter a positive number!\n" ;
   int number ;
   std::cin >> number ;
   std::cout << "Enter a mode( 0 or 1 ) !\n" ;
   int mode ;
   std::cin >> mode ;
   std::cout << findFactors( number , mode ) << '\n' ;
   return 0 ;
}

