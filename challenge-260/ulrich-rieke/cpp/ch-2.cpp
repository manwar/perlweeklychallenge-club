#include <iostream>
#include <algorithm>
#include <string>
#include <iterator>
#include <vector>

int main( ) {
   std::cout << "Enter a word, preferably in capital letters only!\n" ;
   std::string word ;
   std::getline( std::cin , word ) ;
   std::string entered { word } ;
   std::vector<std::string> permus ;
   std::sort( word.begin( ) , word.end( ) ) ;
   do {
      permus.push_back( word ) ;
   } while ( std::next_permutation( word.begin( ) , word.end( ) )) ;
   std::sort( permus.begin( ) , permus.end( ) ) ;
   auto found = std::find( permus.begin( ) , permus.end( ) , entered ) ;
   std::cout << (static_cast<int>(std::distance( permus.begin( ) , found))) 
      + 1 ;
   std::cout << '\n' ;
   return 0 ;
}
