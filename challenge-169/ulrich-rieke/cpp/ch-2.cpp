#include <iostream>
#include <algorithm>
#include <map>
#include <vector>
#include <numeric>
#include <iterator>

std::vector<int> primeDecompose( int n ) {
  std::vector<int> primeFactors ;
  int current = 2 ;
  while ( n != 1 ) {
      if ( n % current == 0 ) {
    primeFactors.push_back( current ) ;
    n /= current ;
      }
      else {
    current++ ;
      }
  }
  return primeFactors ;
}

int my_gcd( int a , int b ) {
  std::vector<int> firstFactors( primeDecompose( a ) ) ;
  std::vector<int> secondFactors( primeDecompose( b ) ) ;
  std::vector<int> common ;
  std::set_intersection( firstFactors.begin( ) , firstFactors.end( ) ,
    secondFactors.begin( ) , secondFactors.end( ) ,
    std::inserter( common, common.begin( ) )) ;
  return std::accumulate( common.begin( ) , common.end( ) , 1 ,
    std::multiplies( ) ) ;
}

bool isAchilles( int n ) {
  std::vector<int> primeFactors( primeDecompose( n ) ) ;
  std::map<int , int> factorCount ;
  for ( int i : primeFactors ) {
      factorCount[ i ]++ ;
  }
  std::vector<int> exponents ;
  for ( auto it = factorCount.begin( ) ; it != factorCount.end( ) ; ++it ) {
      exponents.push_back( it->second ) ;
  }
  if ( *std::min_element(exponents.begin( ) , exponents.end( ) ) >= 2 ) {
      int start = *exponents.begin( ) ;
      return (std::accumulate( exponents.begin( ) , exponents.end( ) , start ,
        []( int a , int b ){ return my_gcd( a , b ) ; } ) == 1 ) ;
  }
  else
      return false ;
}

int main( ) {
  std::vector<int> achillesNumbers ;
  int current = 2 ;
  while ( achillesNumbers.size( ) != 20 ) {
      if ( isAchilles( current ) ) {
    achillesNumbers.push_back( current ) ;
      }
      current++ ;
  }
  for ( int i : achillesNumbers )
      std::cout << i << " " ;
  std::cout << std::endl ;
  return 0 ;
}
