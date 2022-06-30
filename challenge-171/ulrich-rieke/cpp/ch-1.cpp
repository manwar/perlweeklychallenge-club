#include <iostream>
#include <vector>
#include <numeric>

std::vector<int> findDivisors( int n ) {
  std::vector<int> divisors ;
  for ( int i = 1 ; i < (n / 2 ) + 1 ; i++ ) {
      if ( n % i == 0 )
    divisors.push_back( i ) ;
  }
  return divisors ;
}

bool isAbundant( int n ) {
  std::vector<int> divisors = findDivisors( n ) ;
  int sum = std::accumulate( divisors.begin( ) , divisors.end( ) , 0 ) ;
  return sum > n ;
}

int main( ) {
  std::vector<int> oddAbundant ;
  int current = 3 ;
  while ( oddAbundant.size( ) != 20 ) {
      if ( isAbundant( current ) )
    oddAbundant.push_back( current ) ;
      current += 2 ;
  }
  for ( int n : oddAbundant )
      std::cout << n << ' ' ;
  std::cout << std::endl ;
  return 0 ;
}
