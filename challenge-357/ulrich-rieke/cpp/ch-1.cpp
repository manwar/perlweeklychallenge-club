#include <iostream>
#include <vector>
#include <algorithm>
#include <utility>

std::pair<int , int> createPair( int number ) {
   std::vector<int> risingDigits ;
   while ( number != 0 ) {
      risingDigits.push_back( number % 10 ) ;
      number /= 10 ;
   }
   while ( risingDigits.size( ) < 4 ) {
      risingDigits.push_back( 0 ) ;
   }
   int firstDigit = risingDigits[0] ;
   if ( std::all_of( risingDigits.begin( ) , risingDigits.end( ) , 
            [firstDigit]( int i ) { return i == firstDigit ; })) {
      return std::make_pair( -1 , -1 ) ;
   }
   else {
   std::sort( risingDigits.begin( ) , risingDigits.end( ) ) ;
      std::vector<int> descendingDigits { risingDigits } ;
      std::reverse( descendingDigits.begin( ) , descendingDigits.end( ) ) ;
      int greaterNum = descendingDigits[0] * 1000 + descendingDigits[1] * 100
         + descendingDigits[2] * 10 + descendingDigits[3] ;
      int smallerNum = risingDigits[0] * 1000 + risingDigits[1] * 100
         + risingDigits[2] * 10 + risingDigits[3] ;
     return std::make_pair( greaterNum , smallerNum ) ;
   }
}

int main( ) {
   std::cout << "Enter a 4-digit positive integer!\n" ;
   int number ;
   std::cin >> number ;
   auto somePair = createPair( number ) ;
   if ( somePair.first == -1 ) {
      std::cout << -1 << '\n' ;
   }
   else {
      int count = 0 ;
      while ( number != 6174 ) {
         auto aPair { createPair( number ) } ;
         count++ ;
         number = aPair.first - aPair.second ;
      }
      std::cout << count << '\n' ;
   }
   return 0 ;
}
