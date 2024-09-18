#include <iostream>
#include <string>
#include <regex>

int main( ) {
   std::cout << "Enter a string!\n" ;
   std::string word ;
   std::cin >> word ;
   std::string inte {R"(^[-+]?\d+([eE]?[-+]?\d+)*$)"} ;
   std::string decifirst {R"(^[-+]?\d+\.([eE]?[-+]?\d+)*$|^[-+]?\d+\.\d+([eE]?[+-]?\d+)*$)"} ;
   std::string decisecond {R"(^[+-]?\.\d+([eE]?[+-]?\d+$)*$)" } ;
   std::regex integer( inte ) ;
   std::regex decimalfirst ( decifirst ) ;
   std::regex decimalsecond ( decisecond ) ;
   if ( std::regex_match( word , integer ) || std::regex_match( word , decimalfirst ) ||
      std::regex_match( word , decimalsecond ) )
      std::cout << "true" ;
   else 
      std::cout << "false" ;
   std::cout << '\n' ;
   return 0 ;
}
