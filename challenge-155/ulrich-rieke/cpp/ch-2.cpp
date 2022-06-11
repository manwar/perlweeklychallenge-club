#include <iostream>
#include <vector>
#include <algorithm>

int main( ) {
  std::vector<int> fibonaccis{ 0 , 1 } ;
  while ( fibonaccis.size( ) != 500 ) {
      fibonaccis.push_back( *(fibonaccis.begin( ) + fibonaccis.size( ) - 2)
      + *(fibonaccis.begin( ) + fibonaccis.size( ) - 1 ) ) ;
  }
  //tranform fibonaccis into 3rd pisanos
  std::transform( fibonaccis.begin( ) , fibonaccis.end( ) ,
    fibonaccis.begin( ) , []( int i ){ return i % 3 ; } ) ;
  std::vector<int> differences ;
  int n = 2 ;
  //assume equality of ranges of pisano numbers by subtracting
  //them from each other at corresponding places, differences
  //to be stored in the vector of the same name
  differences.push_back( fibonaccis[0] - fibonaccis[2] ) ;
  differences.push_back( fibonaccis[1] - fibonaccis[3] ) ;
  while( std::count( differences.begin( ) , differences.end( ) , 0 )
    != n ) {
      n++ ;
      differences.clear( ) ;
      for ( int i = 0 ; i < n ; i++ )
    differences.push_back( fibonaccis[ i ] - fibonaccis[ i + n ] ) ;
  }
  std::cout << n << std::endl ;
  return 0 ;
}
