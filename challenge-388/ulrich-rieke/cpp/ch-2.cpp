#include <iostream>
#include <algorithm>
#include <numeric>
#include <vector>
#include <utility>
#include <iterator>

int main( ) {
   std::cout << "Enter a positive integer!\n" ;
   int number ;
   std::cin >> number ;
   std::vector<int> original ( number ) ;
   std::iota( original.begin( ) , original.end( ) , 1 ) ;
   std::vector<int> for_permus { original } ;
   std::vector<std::vector<std::pair<int , int>>> all_combis ;
   while ( std::next_permutation( for_permus.begin( ) , for_permus.end( ) )) {
      std::vector<std::pair<int , int>> current_pairs ;
      for ( int i = 0 ; i < for_permus.size( ) ; i++ ) {
         auto p { std::make_pair( original[i] , for_permus[i] ) } ;
         current_pairs.push_back( p ) ;
      }
      if (std::all_of( current_pairs.begin( ) , current_pairs.end( ) , [] 
            ( const auto p ) { return p.first != p.second ; } )) {
         all_combis.push_back( current_pairs ) ;
      }
   }
   auto last = std::unique( all_combis.begin( ) , all_combis.end( ) ) ;
   std::cout << static_cast<int>(std::distance( all_combis.begin( ) , 
            last )) << '\n' ;
   return 0 ;
}
