#include <vector>
#include <iostream>

std::vector<int> findDivisors( int n ) {
  std::vector<int> divisors ;
  for ( int i = 1 ; i < n + 1 ; i++ ) {
      if ( n % i == 0 )
    divisors.push_back( i ) ;
  }
  return divisors ;
}

int main( ) {
  std::vector<int> wanted ;
  int current = 1 ;
  while ( wanted.size( ) < 10 ) {
      std::vector<int> divisors ( findDivisors( current ) ) ;
      if ( divisors.size( ) == 8 )
    wanted.push_back( current ) ;
      current++ ;
  }
  for ( int n : wanted )
      std::cout << n << " " ;
  std::cout << std::endl ;
  return 0 ;
}
