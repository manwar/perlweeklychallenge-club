#include <iostream>
#include <string>
#include <algorithm>
#include <vector>

int main( ) {
   std::cout << "Enter a string!\n" ;
   std::string word ;
   std::cin >> word ;
   std::vector<std::string> forward_pairs , backward_pairs ;
   int len = word.length( ) ;
   for ( int i = 0 ; i < len - 1 ; i++ ) 
      forward_pairs.push_back( word.substr( i , 2 ) ) ;
   std::reverse( word.begin( ) , word.end( ) ) ;
   for ( int i = 0 ; i < len - 1 ; i++ ) 
      backward_pairs.push_back( word.substr( i , 2 ) ) ;
   std::cout << std::boolalpha << std::any_of( forward_pairs.begin( ) , 
         forward_pairs.end( ) , [backward_pairs]( const auto s ) {
         return std::find( backward_pairs.begin( ) , backward_pairs.end( ) , 
               s ) != backward_pairs.end( ) ; } ) << '\n' ;
   return 0 ;
}
   
