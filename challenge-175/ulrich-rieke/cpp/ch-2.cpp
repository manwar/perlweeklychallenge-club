#include <iostream>
#include <vector>
#include <numeric>
#include <algorithm>

int my_gcd( int a , int b ) { //Euclid's algorithm
  if ( b >= a )
      std::swap( a , b ) ;
  while ( a != b ) {
      a = a - b ;
      if ( b >= a )
    std::swap( a , b ) ;
  }
  return a ;
}

int myPhi(  int n ) {
  std::vector<int> totatives ;
  for ( int i = 1 ; i < n ; i++ ) {
      if ( my_gcd( i , n ) == 1 )
    totatives.push_back( i ) ;
  }
  return totatives.size( ) ;
}

bool isPerfectTotient( int n ) {
  if ( n == 1 ) {
      return false ;
  }
  int current = n ;
  std::vector<int> totients ;
  do {
      current = myPhi( current ) ;
      totients.push_back( current ) ;
  } while ( current != 1 ) ;
  return std::accumulate( totients.begin( ) , totients.end( ) , 0 ) == n ;
}

int main( ) {
  std::vector<int> perfectTotients ;
  int current = 1 ;
  while ( perfectTotients.size( ) != 20 ) {
      if ( isPerfectTotient( current ) ) {
    perfectTotients.push_back( current ) ;
      }
      current++ ;
  }
  for ( int i : perfectTotients ) {
      std::cout << i ;
      if ( i != perfectTotients.back( ) )
    std::cout << ',' ;
  }
  std::cout << std::endl ;
  return 0 ;
}
