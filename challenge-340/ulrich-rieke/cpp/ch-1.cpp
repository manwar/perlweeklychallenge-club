#include <string>
#include <regex>
#include <iterator>
#include <iostream>
using namespace std::string_literals ;

int main( ) {
   std::cout << "Enter a string!\n" ;
   std::string line ;
   std::cin >> line ;
   std::regex re( "(.)\\1" ) ;
   while ( std::regex_search( line , re ) ) {
      auto result = std::regex_replace( line, re , ""s ) ;
      line = result ;
   }
   std::cout << line << '\n' ;
   return 0 ;
}
