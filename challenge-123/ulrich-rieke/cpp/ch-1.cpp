#include <iostream>
#include <cmath>
#include <set>
#include <algorithm>
#include <cstdlib>

bool isUgly( int n , const std::set<int> firstPrimes ) {
  std::set<int> divisors ;
  int current = 2 ;
  while ( n > 1 ) {
      if ( n % current == 0 ) {
    divisors.insert( current ) ;
    n /= current ;
      }
      else
    current++ ;
  }
  return std::all_of( divisors.begin( ) , divisors.end( ) ,
    [&firstPrimes]( int i ) { return firstPrimes.find( i ) !=
    firstPrimes.end( ) ; } ) ;
}

int main( int argc , char * argv[ ] ) {
  int n = std::atoi( argv[ 1 ] ) ;
  std::set<int> somePrimes { 2 , 3 , 5 } ;
  int current = 1 ;
  int sumUglies = 1 ;
  while ( sumUglies < n ) {
      current++ ;
      if ( isUgly( current , somePrimes ) )
    sumUglies++ ;
  }
  std::cout << current << std::endl ;
  return 0 ;
}
