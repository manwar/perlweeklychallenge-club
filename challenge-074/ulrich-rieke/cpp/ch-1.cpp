#include <vector>
#include <set>
#include <algorithm>
#include <iostream>
#include <cmath>

int main( ) {
  int num = 0 ;
  std::vector<int> numbers ;
  std::cout << "Enter numbers , -1 to end!\n" ;
  std::cin >> num ;
  while ( num != -1 ) {
      numbers.push_back( num ) ;
      std::cin >> num ;
  }
  std::set<int> numSet ;
  for ( int i : numbers )
      numSet.insert( i ) ; //unique numbers only
  //create a vector to sort the numbers more easily
  std::vector<int> differentNums( numSet.begin( ) , numSet.end( ) ) ;
  std::sort( differentNums.begin( ) , differentNums.end( ) ,
    [&numbers]( int a , int b ) { return std::count( numbers.begin( ),
        numbers.end( ) , a ) > std::count( numbers.begin( ) ,
        numbers.end( ) , b ) ; } ) ;
  int maxFound = std::count( numbers.begin( ) , numbers.end( ) ,
    *differentNums.begin( ) ) ;
  if ( maxFound > floor( static_cast<double>( numbers.size( ) ) / 2 ) )
    std::cout << '\n' << *differentNums.begin( ) << std::endl ;
  else
      std::cout << '\n' << -1 << std::endl ;
  return 0 ;
}
