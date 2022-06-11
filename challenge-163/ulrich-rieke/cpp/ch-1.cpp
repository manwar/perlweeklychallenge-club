#include <iostream>
#include <vector>
#include <set>
#include <numeric>
#include <utility>
#include <algorithm>

int main( ) {
  std::vector<int> input ;
  std::vector<std::pair<int , int>> combis ;
  std::cout << "Please input integer numbers ( 0 to end! )\n" ;
  int number ;
  std::cin >> number ;
  while ( number != 0 ) {
      input.push_back( number ) ;
      std::cout << "Next number ( 0 to end):\n" ;
      std::cin >> number ;
  }
  std::sort( input.begin( ) , input.end( ) ) ;
  for ( int i = 0 ; i < input.size( ) - 1 ; i++ ) {
      for ( int j = i + 1 ; j < input.size( ) ; j++ ) {
    combis.push_back( std::make_pair( input[ i ] , input[ j ] )) ;
      }
  }
  std::set<std::pair<int , int>> uniquePairs { combis.begin( ) , combis.end( ) } ;
  std::vector<int> sums( uniquePairs.size( ) ) ;
  std::transform( uniquePairs.begin( ) , uniquePairs.end( ) , sums.begin( ) ,
    []( const auto & p ) { return p.first & p.second ; } ) ;
  std::cout << std::accumulate( sums.begin( ) , sums.end( ) , 0 ) << std::endl ;
  return 0 ;
}
