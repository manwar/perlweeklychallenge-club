#include <iostream>
#include <string>
#include <algorithm>

int main( ) {
   std::cout << "Enter a word!\n" ;
   std::string haystack ;
   std::cin >> haystack ;
   char needle ;
   std::cout << "Enter a character!\n" ;
   std::cin >> needle ;
   auto pos = haystack.find( needle ) ;
   if ( pos != std::string::npos ) {
      std::string firstPart { haystack.substr( 0 , pos + 1 ) } ;
      std::sort( firstPart.begin( ) , firstPart.end( ) ) ;
      if ( pos + 1 < haystack.length( ) ) 
	 std::cout << ( firstPart + haystack.substr( pos + 1 ) ) << '\n' ;
      else 
	 std::cout << firstPart << '\n' ;
   }
   else {
      std::cout << haystack << '\n' ;
   }
   return 0 ;
}

