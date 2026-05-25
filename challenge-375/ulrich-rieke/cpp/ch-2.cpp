#include <iostream>
#include <vector>
#include <algorithm>
#include <string>

int main( ) {
   std::cout << "Enter a number string!\n" ;
   std::string numberstring ;
   std::cin >> numberstring ;
   std::cout << "Enter a k value!\n" ;
   int k ;
   std::cin >> k ;
   int len = numberstring.length( ) ;
   int result = 0 ;
   if ( k == len ) 
      result = 1 ;
   else {
      if ( k > len ) {
         result = 0 ;
      }
      else {
         std::vector<int> numbers ;
         for ( int i = 0 ; i < len - k + 1 ; i++ ) {
            numbers.push_back( std::stoi( numberstring.substr( i , k ) )) ;
         }
         result = std::count_if( numbers.begin( ) , numbers.end( ) , 
               [numberstring]( const int n ){ return std::stoi(
                  numberstring ) % n == 0 ; } ) ;
      }
   }
   std::cout << result << '\n' ;
   return 0 ;
}

