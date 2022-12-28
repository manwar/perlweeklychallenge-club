#include <vector>
#include <iostream>
#include <algorithm>
#include <iterator>

int main( ) {
  std::cout << "Enter a number of integers , a negative integer to end!\n"
      ;
  std::vector<int> numbers ;
  int num ;
  std::cin >> num ;
  while ( num > - 1 ) {
      numbers.push_back( num ) ;
      std::cin >> num ;
  }
  std::vector<int> ordered ;
  std::copy_if( numbers.begin( ) , numbers.end( ) ,
    std::back_inserter( ordered ) , []( int i ) {
    return i != 0 ; } ) ;
  int zeronum = std::count( numbers.begin( ) , numbers.end( ) , 0 ) ;
  if ( zeronum != 0 ) {
      for ( int i = 0 ; i < zeronum ; i++ )
    ordered.push_back( 0 ) ;
  }
  std::cout << ordered.size( ) << '\n' ;
  std::cout << '(' ;
  for ( int n : ordered ) {
      std::cout << n << ' ' ;
  }
  std::cout << ")\n" ;
  return 0 ;
}
