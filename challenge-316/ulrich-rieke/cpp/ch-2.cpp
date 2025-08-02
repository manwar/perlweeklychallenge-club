#include <iostream>
#include <string>

int main( ) {
   std::cout << "Enter a string!\n" ;
   std::string firststr ;
   std::cin >> firststr ;
   std::cout << "Enter a second string somewhat longer than the first one!\n";
   std::string secondstr ;
   std::cin >> secondstr ;
   bool result = true ;
   for ( auto c : firststr ) {
	 auto pos = secondstr.find( c ) ;
	 if ( pos != std::string::npos ) {
	    secondstr = secondstr.substr( pos ) ;
	 }
	 else {
	    result = false ;
	    break ;
	 }
   }
   std::cout << std::boolalpha << result << '\n' ;
   return 0 ;
}
	    
