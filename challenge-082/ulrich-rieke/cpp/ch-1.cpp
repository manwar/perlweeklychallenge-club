#include <vector>
#include <iostream>
#include <iterator>
#include <algorithm>
#include <cstdlib>

std::vector<int> findDivisors( int n ) {
  std::vector<int> divisors ;
  for ( int i = 1 ; i < n + 1 ; i++ ) {
      if ( n % i == 0 )
    divisors.push_back( i ) ;
  }
  return divisors ;
}

int main( int argc , char * argv[ ] ) {
  if ( argc != 3 ) {
      std::cerr << "2 arguments required!\n" ;
      return 1 ;
  }
  int m = std::atoi( argv[ 1 ] ) ;
  int n = std::atoi( argv[ 2 ] ) ;
  std::vector<int> commonFactors ;
  std::vector<int> divisorsM = findDivisors( m ) ;
  std::vector<int> divisorsN = findDivisors( n ) ;
  //divisorsM and divisorsN are already sorted, so the next algorithm's
  //precondition of sorted containers as arguments is fulfilled
  std::set_intersection( divisorsM.begin( ) , divisorsM.end( ) ,
    divisorsN.begin( ) , divisorsN.end( ) ,
    std::back_inserter( commonFactors ) ) ;
  std::cout << "[ " ;
  for ( int i : commonFactors ) {
      std::cout << i << ' ' ;
  }
  std::cout << "]\n" ;
  return 0 ;
}
