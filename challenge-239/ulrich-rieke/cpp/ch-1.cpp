#include <iostream>
#include <string>
#include <regex>

int main( ) {
   std::string firstLine ;
   std::string secondLine ;
   std::cout << "Enter some strings, separated by blanks!\n" ;
   std::getline( std::cin , firstLine ) ;
   std::cout << "Enter some more strings, separated by blanks!\n" ;
   std::getline( std::cin, secondLine ) ;
   std::string replace( "" ) ;
   std::string remove( "\\s+" ) ;
   std::regex forRemoval( remove ) ;
   std::string firstConcat ( std::regex_replace( firstLine , forRemoval , 
	    replace )) ;
   std::string secondConcat( std::regex_replace( secondLine, forRemoval , 
	    replace ) ) ;
   if ( firstConcat == secondConcat ) 
      std::cout << "true\n" ;
   else 
      std::cout << "false\n" ;
   return 0 ;
}
