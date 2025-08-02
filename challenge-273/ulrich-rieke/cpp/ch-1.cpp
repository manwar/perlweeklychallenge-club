#include <iostream>
#include <string>
#include <algorithm>
#include <cmath>

int main( ) {
   std::cout << "Enter a word!\n" ;
   std::string word ;
   std::cin >> word ;
   std::cout << "Enter a character!\n" ;
   char c ;
   std::cin >> c ;
   int frequency = std::count( word.begin( ) , word.end( ) , c ) ;
   double percentage = (static_cast<double>( frequency ) / word.length( ) ) 
      * 100.0 ;
   double bottom = std::floor( percentage ) ;
   if ( percentage - bottom > 0.4 ) {
      std::cout << bottom + 1 << '\n' ;
   }
   else {
      std::cout << bottom << '\n' ;
   }
   return 0 ;
}

