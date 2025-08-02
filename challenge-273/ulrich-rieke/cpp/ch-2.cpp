#include <iostream>
#include <string>

int main( ) {
   std::cout << "Enter a word!\n" ;
   std::string word ;
   std::cin >> word ;
   std::string result { "false" } ;
   auto pos = word.find( 'b' ) ;
   if ( pos != std::string::npos ) {
      if ( word.substr( pos + 1 ).find( 'a' ) == std::string::npos ) 
	 result = "true" ;
   }
   std::cout << result << '\n' ;
   return 0 ;
}
