#include <vector>
#include <iostream>
#include <cmath>
#include <algorithm>

bool isDisarium( int n ) {
  int compareTo = n ;
  std::vector<int> digits ;
  while ( n != 0 ) {
      digits.push_back( n % 10 ) ;
      n /= 10 ;
  }
  std::reverse( digits.begin( ) , digits.end( ) ) ;
  int sum = 0 ;
  for ( int i = 1 ; i < digits.size( ) + 1 ; i++ ) {
      sum += static_cast<int>( std::pow( static_cast<double>( digits[ i - 1 ] ) ,
          static_cast<double>( i ))) ;
  }
  return sum == compareTo ;
}

int main( ) {
  std::vector<int> disariums ;
  int current = 0 ;
  while ( disariums.size( ) != 19 ) {
      if ( isDisarium( current ) )
    disariums.push_back( current ) ;
      current++ ;
  }
  for ( int i : disariums ) {
      std::cout << i ;
      if ( i != disariums.back( ) )
    std::cout << ',' ;
  }
  std::cout << std::endl ;
  return 0 ;
}
