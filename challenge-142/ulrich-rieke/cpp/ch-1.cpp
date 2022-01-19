#include <iostream>
#include <vector>
#include <cstdlib>

int main( int argc, char * argv[ ] ) {
  int m = std::atoi( argv[ 1 ] ) ;
  int n = std::atoi( argv[ 2 ] ) ;
  std::vector<int> divisors ;
  for ( int i = 1 ; i < m + 1 ; i++ ) {
      if ( m % i == 0 ) {
    divisors.push_back( i ) ;
      }
  }
  int output = 0 ;
  for ( int num : divisors ) {
      if ( num % 10 == n )
    output++ ;
  }
  std::cout << output << std::endl ;
  return 0 ;
}
