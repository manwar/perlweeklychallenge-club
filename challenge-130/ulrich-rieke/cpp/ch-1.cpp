#include <vector>
#include <algorithm>
#include <map>
#include <iostream>

int main( ) {
  std::cout << "Please enter positive integers, -1 to end!\n" ;
  std::vector<int> input ;
  int number ;
  std::cin >> number ;
  while ( number != -1 ) {
      input.push_back( number ) ;
      std::cin >> number ;
  }
  std::map<int , int> numfrequencies ;
  for ( int n : input ) {
      if ( numfrequencies.find( n ) == numfrequencies.end( ) )
    numfrequencies[ n ] = std::count( input.begin( ) , input.end( ) ,
    n );
  }
  auto it = std::find_if( numfrequencies.begin( ) , numfrequencies.end( ),
    [ ]( auto & p ) { return p.second % 2 == 1 ; } ) ;
  std::cout << it->first << std::endl ;
  return 0 ;
}
