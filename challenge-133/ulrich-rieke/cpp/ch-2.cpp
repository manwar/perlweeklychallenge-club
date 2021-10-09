#include <iostream>
#include <vector>
#include <cmath>
#include <map>
#include <iterator>
#include <algorithm>

bool isPrime( int n ) {
  const int stop = std::sqrt( static_cast<double>( n ) ) ;
  for ( int i = 2 ; i <= stop ; i++ ) {
      if ( n % i == 0 )
    return false ;
  }
  return true ;
}

bool isComposite( int n ) {
  return ( ( ! isPrime( n ) ) && ( n != 1 ) ) ;
}

int findDigitSum( int n ) {
  int digitsum = 0 ;
  while ( n != 0 ) {
      digitsum += ( n % 10 ) ;
      n /= 10 ;
  }
  return digitsum ;
}

std::vector<int> primeFactorize( int n ) {
  std::vector<int> primeFactors ;
  int current = 2 ;
  while ( n != 1 ) {
      if ( n % current == 0 ) {
    n /= current ;
    primeFactors.push_back( current ) ;
      }
      else {
    do {
        current++ ;
    } while ( ! isPrime( current ) ) ;
      }
  }
  return primeFactors ;
}

bool isSmithNumber( int n ) {
  int digitsum = findDigitSum( n ) ;
  std::vector<int> primeFactors = primeFactorize( n ) ;
  std::map<int , int> factorCount ;
  for ( auto fac : primeFactors )
      factorCount[ fac ]++ ;
  int factorSum = 0 ;
  for ( auto & p : factorCount )
      factorSum += findDigitSum( p.first ) * p.second ;
  return factorSum == digitsum ;
}

int main( ) {
  std::vector<int> smithNumbers ;
  int current = 0 ;
  while ( smithNumbers.size( ) < 10 ) {
      current++ ;
      if ( ( isComposite( current ) ) && ( isSmithNumber( current ) ) )
    smithNumbers.push_back( current ) ;
  }
  std::copy( smithNumbers.begin( ) , smithNumbers.end( ) ,
    std::ostream_iterator<int>( std::cout , " " )) ;
  std::cout << std::endl ;
  return 0 ;
}
