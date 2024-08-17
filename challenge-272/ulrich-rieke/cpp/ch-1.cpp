#include <iostream>
#include <string>
#include <regex>

int main( ) {
   std::cout << "Enter a valid IPv4 address !\n" ;
   std::string address ;
   std::cin >> address ;
   std::string lookFor { "\\." } ;
   std::regex rgx( lookFor ) ;
   std::string result {std::regex_replace( address , rgx , std::string(
	    "[.]" ) ) } ;
   std::cout << result << '\n' ;
   return 0 ;
}
