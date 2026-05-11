#include <string>
#include <iostream>
#include <map> 
#include <algorithm>

int main( ) {
   std::cout << "Enter a string!\n" ;
   std::string word ;
   std::cin >> word ;
   std::map<char , int> frequencies ;
   for ( char c : word ) 
      frequencies[c]++ ;
   if ( std::all_of( frequencies.begin( ) , frequencies.end( ) , [](
               const auto &p) { return p.second == 1 ; } ) ) 
      std::cout << -1 << '\n' ;
   else {
      int max_distance { 0 } ;
      for ( auto p : frequencies ) {
         if ( p.second > 1 ) {
            int distance = word.rfind( p.first ) - word.find( p.first ) 
               - 1 ;
            if ( distance > max_distance ) 
               max_distance = distance ;
         }
      }
      std::cout << max_distance << '\n' ;
   }
   return 0 ;
}
