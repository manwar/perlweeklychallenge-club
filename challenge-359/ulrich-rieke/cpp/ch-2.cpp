#include <string>
#include <iterator>
#include <algorithm>
#include <iostream>

int main( ) {
   std::cout << "Enter a word with alphabetic characters only!\n" ;
   std::string word ;
   std::cin >> word ;
   auto found = std::adjacent_find( word.begin( ) , word.end( ) ) ;
   while ( found != word.end( ) ) {
      word.replace( found , std::next( found , 2 ) , "" ) ;
      found = std::adjacent_find( word.begin( ) , word.end( ) ) ;
   }
   if ( word.length( ) == 0 ) {
      std::cout << "\"\"" ;
   }
   else {
      std::cout << word ;
   }
   std::cout << '\n' ;
   return 0 ;
}
