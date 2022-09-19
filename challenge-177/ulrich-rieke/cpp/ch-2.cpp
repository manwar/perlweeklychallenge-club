#include <iostream>
#include <string>
#include <cmath>
#include <algorithm>

bool isPrime( int n ) {
  if ( n == 0 )
      return false ;
  if ( n == 1 )
      return false ;
  if ( n == 2 )
      return true ;
  int root = static_cast<long>( floor( sqrt( static_cast<double>( n ) ))) ;
  for ( int i = 2 ; i < root + 1 ; i++ )
      if ( n % i == 0 )
        return false ;
  return true ;
}

bool myCondition( int n ) {
  std::string numberstring { std::to_string( n ) } ;
  std::string compare { numberstring } ;
  std::reverse( numberstring.begin( ) , numberstring.end( ) ) ;
  int len = compare.length( ) ;
  return isPrime( n ) && (compare == numberstring ) &&
      (compare.substr( len / 2 , 1 ) == "0" ) &&
      std::count( compare.begin( ) , compare.end( ) , '0' ) == 1 ;
}

int main( ) {
  int current = 100 ;
  std::vector<int> cyclopses ;
  while ( cyclopses.size( ) != 20 ) {
      if ( myCondition( current ) )
    cyclopses.push_back( current ) ;
      current++ ;
      //if number has an even number of digits multiply by 10
      if ( std::to_string(current).length( ) % 2 == 0 )
    current *= 10 ;
  }
  for ( int i : cyclopses )
      std::cout << i << ' ' ;
  std::cout << std::endl ;
  return 0 ;
}
