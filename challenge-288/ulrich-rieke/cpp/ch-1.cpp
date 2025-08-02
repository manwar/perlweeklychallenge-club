#include <iostream>
#include <string>
#include <algorithm>
#include <cstdlib>

bool isPalindrome( int number ) {
   auto numberstring = std::to_string( number ) ;
   auto reversed { numberstring } ;
   std::reverse( reversed.begin( ) , reversed.end( ) ) ;
   return reversed == numberstring ;
}

int main( ) {
   std::cout << "Please enter a number!\n" ;
   int number ;
   std::cin >> number ;
   int current = number - 1 ;
   while ( ! isPalindrome( current ) )  
      current-- ;
   auto minusnum = current ;
   auto minusdiff = std::abs( minusnum - number ) ;
   current = number + 1 ;
   while ( ! isPalindrome( current ) ) 
      current++ ;
   auto plusnum = current ;
   auto plusdiff = std::abs( plusnum - number ) ;
   if ( plusdiff == minusdiff ) 
      std::cout << minusnum << '\n' ;
   else {
      if ( plusdiff < minusdiff )  
	 std::cout << plusnum << '\n' ;
      else 
	 std::cout << minusnum << '\n' ;
   }
   return 0 ;
}

