#include <string>
#include <iostream>
#include <regex>
using namespace std::string_literals ;

int main( ) {
   std::cout << "Enter a string with lowercase English letters and digits only!\n" ;
   std::string word ;
   std::cin >> word ;
   std::regex wanted { "\\D\\d" } ;
   while ( std::regex_search( word , wanted )) {
      word = std::regex_replace( word , wanted , "" , 
	    std::regex_constants::format_first_only) ;
   }
   if ( word.length( ) > 0 ) {
      std::cout << word ;
   }
   else {
      std::cout << "\"\"" ;
   }
   std::cout << '\n' ;
   return 0 ;
}
