#include <string>
#include <map>
#include <algorithm>
#include <iostream>

int main( ) {
   std::cout << "Enter a string with English letters only!\n" ;
   std::string word ;
   std::cin >> word ;
   const std::string vowels { "aeiouAEIOU" } ;
   std::map<char , int> vowelcount , consocount ;
   for ( char c : word ) {
      if (vowels.find( c ) != std::string::npos ) {
         vowelcount[c]++ ;
      }
      else {
         consocount[c]++ ;
      }
   }
   int vowelmax { 0 } ;
   int consomax { 0 } ;
   if ( vowelcount.size( ) > 0 ) {
      vowelmax += std::max_element( vowelcount.begin( ) , vowelcount.end( ) , 
            []( const auto p1 , const auto p2 ) { return p1.second < p2.second 
            ; })->second ;
   }
   if ( consocount.size( ) > 0 ) {
      consomax += std::max_element( consocount.begin( ) , consocount.end( ) , 
            []( const auto p1 , const auto p2 ) { return p1.second < 
            p2.second ; } )->second ;
   }
   std::cout << vowelmax + consomax << '\n' ;
   return 0 ;
}
