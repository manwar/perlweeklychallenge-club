#include <vector>
#include <iostream>
#include <algorithm>

void  reorderList( std::vector<int> & numbers ,
      std::vector<int> & indices ) {
  std::vector<int> sublist ;
  for ( int i : indices ) {
      sublist.push_back( numbers[ i ] ) ;
  }
  std::sort( indices.begin( ) , indices.end( ) ) ;
  std::sort( sublist.begin( ) , sublist.end( ) ) ;
  for ( int i = 0 ; i < indices.size( ) ; i++ ) {
      numbers[ indices[ i ]] = sublist[ i ] ;
  }
}

int main( ) {
  std::vector<int> numbers { 10 , 4 , 1 , 8 , 12 , 3 } ;
  std::vector<int> indices { 0 , 2 , 5 } ;
  reorderList( numbers , indices ) ;
  for ( int i : numbers )
      std::cout << i << ' ' ;
  std::cout << std::endl ;
  return 0 ;
}
