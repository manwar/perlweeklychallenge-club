#include <iostream>
#include <vector>
#include <algorithm>
#include <cstdlib>

std::vector<int> toBaseDigits( int n , int base ) {
  std::vector<int> baseDigits ;
  while ( n != 0 ) {
      baseDigits.push_back( n % base ) ;
      n /= base ;
  }
  return baseDigits ;
}

int main( int argc, char * argv[] ) {
  int n = std::atoi( argv[1] ) ;
  while ( n <= 3 ) {
      std::cout << "number must be greater than 3! Re-enter!\n" ;
      std::cin >> n ;
  }
  bool isBrazilian = false ;
  for ( int i = 2 ; i < n - 1 ; i++ ) {
      std::vector<int> digits { toBaseDigits( n , i ) } ;
      if ( std::count( digits.begin( ) , digits.end( ) , *(digits.begin( ) )) ==
        digits.size( ) ) {
    isBrazilian = true ;
    break ;
      }
  }
  if ( isBrazilian )
      std::cout << 1 ;
  else
      std::cout << 0 ;
  std::cout << std::endl ;
  return 0 ;
}
