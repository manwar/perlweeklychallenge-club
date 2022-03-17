#include <iostream>
#include <vector>
#include <cmath>
#include <numeric>
#include <set>
#include <algorithm>

bool isPrime( int number ) {
  int stop =  std::sqrt( static_cast<double>( number ) ) ;
  for ( int i = 2 ; i <= stop ; ++i )
      if ( number % i == 0 )
        return false ;
  return true ;
}

int main( ) {
  std::vector<int> primeNumbers { 2 } ;
  int n = 2 ;
  while ( primeNumbers.size( ) != 11 ) {
      n++ ;
      if ( isPrime( n ) ) {
    primeNumbers.push_back( n ) ;
      }
  }
  std::vector<int> primorials { 2 } ;
  for ( int i = 1 ; i < 11 ; i++ ) {
      if ( i < 10 ) {
    primorials.push_back( std::accumulate( primeNumbers.begin( ) ,
          primeNumbers.begin( ) + i + 1 , 1 , std::multiplies<int>() )) ;
      }
      else {
    primorials.push_back( std::accumulate( primeNumbers.begin( ) ,
          primeNumbers.end( ) , 1 , std::multiplies<int>() )) ;
      }
  }
  std::vector<int> fortunates ;
  int current = 0 ;
  std::set<int> fortunaSet ;
  while ( fortunaSet.size( ) != 8 ) {
      int num = primorials[ current ] ;
      int m = 2 ;
      int sum = num + m ;
      while ( ! isPrime( sum ) ) {
    m++ ;
    sum = num + m ;
      }
      current++ ;
      fortunates.push_back( m ) ;
      std::sort( fortunates.begin( ) , fortunates.end( ) ) ;
      for ( int n : fortunates )
    fortunaSet.insert( n ) ;
  }
  for ( int i : fortunaSet ) {
      std::cout << i << ' ' ;
  }
  std::cout << std::endl ;
  return 0 ;
}
