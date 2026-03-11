#include <iostream>
#include <string>
#include <algorithm>
#include <regex>

std::string solution( std::string word ) {
   std::regex first_re( R"(\(\))" ) ;
   std::regex second_re( R"(\(al\))" ) ;
   std::string result { std::regex_replace( word , first_re , "o" ) } ;
   result = std::regex_replace( result , second_re , "al" ) ;
   return result ;
}

int main( ) {
   std::cout << solution( "G()(al)" ) << '\n' ;
   std::cout << solution( "G()()()()(al)" ) << '\n' ;
   std::cout << solution( "(al)G(al)()()" ) << '\n' ;
   std::cout << solution( "()G()G" ) << '\n' ;
   std::cout << solution( "(al)(al)G()()" ) << '\n' ;
   return 0 ;
}
