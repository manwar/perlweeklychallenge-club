#include <iostream>
#include <string>
#include <algorithm>
#include <vector>

int main( ) {
   std::cout << "Enter an alphanumeric word!\n" ;
   std::string word ;
   std::cin >> word ;
   std::string numbers {"0123456789"} ;
   std::vector<int> foundNums ;
   for ( char c : word ) {
      if ( numbers.find( c ) != std::string::npos ) { //c is a number
         int n = static_cast<int>( c ) - 48 ;//convert from ASCII code to number
         if ( std::find( foundNums.begin( ) , foundNums.end( ) , n ) ==
               foundNums.end( ) ) //number not yet in vector
            foundNums.push_back( n ) ;
      }
   }
   int len = foundNums.size( ) ;
   if ( len == 0 || len == 1 ) {
      std::cout << -1 << '\n' ;
   }
   else {
      std::sort( foundNums.begin( ) , foundNums.end( ) , []( int a , int b)
            { return a > b ; } ) ; //sort in descending order
      std::cout << foundNums[1] << '\n' ;
   }
   return 0 ;
}
