#include <string>
#include <iostream>

int findPossibilities( const std::string & text ) {
   int possibilities = 1 ;
   if ( text.substr( 0 , 2 ) == "??" ) {
      possibilities  *= 24 ;
   }
   else {
      if ( text.substr( 0 , 1 ) == "?" ) {
         int number = static_cast<int>( text[1] ) - 48 ;
         if ( number < 4 ) {
            possibilities *= 3 ;
         }
         else {
            possibilities *= 2 ;
         }
      }
      if ( text.substr( 1 , 1 ) == "?" ) {
         int number = static_cast<int>( text[0] ) - 48 ;
         if ( number < 2 ) {
            possibilities *= 10 ;
         }
         else {
            possibilities *= 4 ;
         }
      }
   }
   if ( text.substr( 3, 1 ) == "?" ) {
      possibilities *= 6 ;
   }
   if ( text.substr( 4 , 1 ) == "?" ) {
      possibilities *= 10 ;
   }
   return possibilities ;
}

int main( ) {
   std::cout << findPossibilities("?2:34" ) << '\n' ;
   std::cout << findPossibilities("?4:?0" ) << '\n' ;
   std::cout << findPossibilities("??:??" ) << '\n' ;
   std::cout << findPossibilities("?3:45" ) << '\n' ;
   std::cout << findPossibilities("2?:15" ) << '\n' ;
   return 0 ;
}



