#include <iostream>

int main( ) {
   std::cout << "Enter a positive integer!\n" ;
   int number ;
   std::cin >> number ;
   int total { 0 } ;
   for ( int a = 1 ; a < number + 1 ; a++ ) {
      for ( int b = 1 ; b < number + 1 ; b++ ) {
         for ( int c = 1 ; c < number + 1 ; c++ ) {
            if ( a * a + b * b == c * c ) 
               total++ ;
         }
      }
   }
   std::cout << total << '\n' ;
   return 0 ;
}
