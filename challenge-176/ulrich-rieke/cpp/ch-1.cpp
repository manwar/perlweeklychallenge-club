#include <iostream>
#include <algorithm>
#include <vector>

std::vector<int> toDigits( int n ) {
  std::vector<int> digits ;
  while ( n != 0 ) {
      digits.push_back( n % 10 ) ;
      n /= 10 ;
  }
  return digits ;
}

bool isPermutedMultiple( int n ) {
  std::vector<int> startDigits { toDigits( n ) } ;
  std::sort( startDigits.begin( ) , startDigits.end( ) ) ;
  int mult = 2 ;
  std::vector<int> productDigits ;
  while ( mult != 6 ) {
      productDigits = toDigits( n * mult )  ;
      std::sort( productDigits.begin( ) , productDigits.end( ) ) ;
      if ( productDigits != startDigits ) {
    return false ;
      }
      mult++ ;
  }
  productDigits = toDigits( n * 6 ) ;
  std::sort( productDigits.begin( ) , productDigits.end( ) ) ;
  if ( productDigits == startDigits ) {
      return true ;
  }
  else {
      return false ;
  }
}

int main( ) {
  int current = 1 ;
  while ( ! isPermutedMultiple( current ) )
      current++ ;
  std::cout << current << std::endl ;
  return 0 ;
}
