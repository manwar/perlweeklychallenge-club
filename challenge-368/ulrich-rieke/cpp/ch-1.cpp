#include <iostream>
#include <string>

int main( ) {
   std::cout << "Enter a numberstring!\n" ;
   std::string numberstring ;
   std::cin >> numberstring ;
   std::cout << "Enter a number character!\n" ;
   char number ;
   std::cin >> number ;
   if ( numberstring[0] == number && numberstring[0] < numberstring[1] ) {
      numberstring = numberstring.substr( 1 ) ;
   }
   else {
      auto pos = numberstring.rfind( number ) ;
      if (pos != std::string::npos) {
         numberstring = numberstring.substr( 0 , pos ) + numberstring.
            substr( pos + 1 ) ;
      }
   }
   std::cout << numberstring << '\n' ;
   return 0 ;
}
