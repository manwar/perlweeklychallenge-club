#include <vector>
#include <iostream>
#include <numeric>
#include <utility>
#include <cstdlib>
#include <algorithm>

int main( int argc, char * argv[] ) {
  int n = std::atoi( argv[1] ) ;
  while ( n <= 0 ) {
      std::cout << "Please enter an integer greater than 0!\n" ;
      std::cin >> n ;
  }
  std::vector<int> numerators( n  ) ;
  std::vector<int> denominators( n + 1 ) ;
  std::iota( numerators.begin( ) , numerators.end( ) , 1) ;
  std::iota( denominators.begin( ) , denominators.end( ) , 0 ) ;
  std::vector<std::pair<int, int>> fractions ;
  fractions.push_back( std::make_pair( 0 , 1 ) ) ;
  for ( int i : numerators ) {
      for ( int j : denominators ) {
    if ( i < j && (std::lcm( i , j ) == i * j)) {
        fractions.push_back( std::make_pair( i , j )) ;
    }
      }
  }
  std::sort( fractions.begin( ) , fractions.end( ) ,
    []( const auto & a, const auto & b ) { return
    (static_cast<double>(a.first) / static_cast<double>(a.second)) <
    (static_cast<double>(b.first) / static_cast<double>(b.second));} );
  for ( auto & p : fractions )
      std::cout << p.first << '/' << p.second << ", " ;
  std::cout << "1/1" << std::endl ;
  return 0 ;
}
