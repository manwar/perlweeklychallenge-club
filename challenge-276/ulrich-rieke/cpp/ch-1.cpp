#include <iostream>
#include <vector>
#include <iterator>
#include <utility>
#include <algorithm>

int main( ) {
   std::cout << "Enter some positive integers , separated by blanks, 'e' to end!\n" ;
   std::vector<int> numbers { std::istream_iterator<int>( std::cin ) , 
      std::istream_iterator<int>( ) } ;
   std::vector<std::pair<int , int>> combinations ;
   int len = numbers.size( ) ;
   for ( int i = 0 ; i < len - 1 ; i++ ) {
      for ( int j = i + 1 ; j < len ; j++ ) {
	 combinations.push_back( std::make_pair( numbers[i] , numbers[j] ) ) ;
      }
   }
   std::cout << std::count_if( combinations.begin( ) , combinations.end( ) , []
	 ( const auto & p ) { return (p.first + p.second) % 24 == 0 ; } ) << '\n' ;
   return 0 ;
}
