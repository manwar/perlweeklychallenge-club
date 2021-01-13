#include <iostream>
#include <set>
#include <algorithm>
#include <vector>
#include <numeric>
#include <iterator>

std::vector<int> findDigits( int n ) {
  int divisor = 100 ;
  std::vector<int> digits ;
  while ( divisor > 1 ) {
      int d = n / divisor ;
      digits.push_back( d ) ;
      n = n % divisor ;
      divisor = divisor / 10 ;
  }
  digits.push_back( n ) ;
  return digits ;
}

bool isColourful( int n ) {
  if ( n > 99 && n < 1000 ) {
      std::vector<int> digits { findDigits( n ) } ;
      std::set<int> products ;
      products.insert( digits[0] * digits[1] ) ;
      products.insert( digits[1] * digits[2] ) ;
      products.insert( digits[0] * digits[1] * digits[2] ) ;
      products.insert ( digits[0] * digits[2] ) ;
      for ( int i = 0 ; i < 3 ; i++ )
    products.insert( digits[ i ] ) ;
      return products.size( ) == 7 ;
  }
  return false ;
}

int main( ) {
  std::vector<int> numbers( 900 ) ;
  std::iota( numbers.begin( ) , numbers.end( ) , 100 ) ;
  std::vector<int> colourfuls ;
  for ( int i : numbers ) {
      if ( isColourful( i ) ) {
    colourfuls.push_back( i ) ;
      }
  }
  std::ostream_iterator<int> output( std::cout , "\n" ) ;
  std::copy( colourfuls.begin( ) , colourfuls.end( ) , output ) ;
  return 0 ;
}
