#include <iostream>
#include <string>
#include <algorithm>

bool isPalindrome( const std::string & word ) {
   std::string compare { word } ;
   std::reverse( compare.begin( ) , compare.end( ) ) ;
   return compare == word ;
}

int main( ) {
   std::cout << "Enter a string!\n" ;
   std::string word ;
   std::cin >> word ;
   if ( isPalindrome( word ) ) 
      std::cout << word << '\n' ;
   else {
      int maxi = 1 ;
      int len { static_cast<int>( word.length( ) ) } ;
      for ( int howmany = 2 ; howmany < len ; howmany++ ) {
         std::string current { word.substr( 0 , howmany ) } ;
         if ( isPalindrome( current ) ) {
            if ( howmany - 1 > maxi ) {
               maxi = howmany - 1 ;
            }
         }
      }
      std::string rest ;
      if ( maxi == 1 ) {
         rest = word.substr( 1 ) ;
      }
      else {
         rest = word.substr( maxi + 1 ) ;
      }
      std::reverse( rest.begin( ) , rest.end( ) ) ;
      std::cout << rest + word << '\n' ;
   }
   return 0 ;
}
