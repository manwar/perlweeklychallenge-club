#include <iostream>
#include <vector>
#include <set>
#include <cmath>

bool isPrime( int i ) {
  if ( i == 1 )
      return false ;
  else {
      int stop = std::sqrt( static_cast<double>( i ) ) ;
      for ( int d = 2 ; d <= stop ; d++ )
    if ( i % d == 0 )
        return false ;
      return true ;
  }
}

std::vector<int> findDivisors( int n ) {
  std::vector<int> divisors ;
  for ( int i = 1 ; i < n + 1 ; i++ ) {
      if ( n % 1 == 0 )
    divisors.push_back( i ) ;
  }
  return divisors ;
}

std::vector<int> primeFactorialize( int n ) {
  std::vector<int> primeDecomposition ;
  std::vector<int> divisors = findDivisors( n ) ;
  std::vector<int> primeFactors ;
  for ( int i : divisors ) {
      if ( isPrime( i ) )
    primeFactors.push_back( i ) ;
  }
  int num = 0 ;
  while ( n != 1 ) {
      int nextFactor = primeFactors[ num ] ;
      while ( n % nextFactor == 0 ) {
    primeDecomposition.push_back( nextFactor ) ;
    n /= nextFactor ;
      }
      if ( num + 1 < primeFactors.size( ) )
    num++ ;
  }
  return primeDecomposition ;
}

bool isSquareFree( int n ) {
  if ( n == 1 ) {
      return true ;
  }
  else {
      std::vector<int> primeFactors = primeFactorialize( n ) ;
      std::set<int> numset( primeFactors.begin( ) , primeFactors.end( ) ) ;
      return primeFactors.size( ) == numset.size( ) ;
  }
}

int main( ) {
  std::vector<int> squareFrees ;
  int current = 1 ;
  while ( current < 501 ) {
      if ( isSquareFree( current ) )
    squareFrees.push_back( current ) ;
      current++ ;
  }
  int count = 1 ;
  for ( int i : squareFrees ) {
      std::cout << i << " " ;
      count++ ;
      if ( count % 15 == 0 )//improves the output slightly
    std::cout << std::endl ;
  }
  std::cout << std::endl ;
  return 0 ;
}
