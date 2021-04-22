#include <iostream>
#include <vector>
#include <algorithm>
#include <iterator>
#include <numeric>

std::vector<int> findDivisors( int n ) {
  std::vector<int> divisors ;
  if ( n > 3 ) {
      for ( int i = 2 ; i < n ; i++ ) {
    if ( n % i == 0 ) {
        divisors.push_back( i ) ;
    }
      }
  }
  return divisors ;
}

int main( ) {
  std::vector<int> chowlanumbers ;
  int n = 0 ;
  while ( chowlanumbers.size( ) < 20 ) {
      std::vector<int> divs = findDivisors( ++n ) ;
      if ( divs.size( ) == 0 )
    chowlanumbers.push_back( 0 ) ;
      else
    chowlanumbers.push_back( std::accumulate( divs.begin( ) , divs.end( ) , 0 )) ;
  }
  std::copy( chowlanumbers.begin( ) , chowlanumbers.end( ) ,
    std::ostream_iterator<int>( std::cout , " " ) ) ;
  std::cout << std::endl ;
  return 0 ;
}
