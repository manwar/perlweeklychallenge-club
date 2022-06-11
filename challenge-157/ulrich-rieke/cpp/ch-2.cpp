#include <iostream>
#include <vector>
#include <cstdlib>
#include <map>
#include <string>
#include <numeric>
#include <algorithm>

std::vector<std::string> toBaseDigits( int n , int base ,
      const std::map<int,std::string> & extendedBases ) {
  std::vector<std::string> baseDigits ;
  while ( n != 0 ) {
      int remainder = n % base ;
      if ( remainder > 10 )
    baseDigits.push_back( extendedBases.find(remainder)->second ) ;
      else
    baseDigits.push_back( std::to_string( remainder )) ;
      n /= base ;
  }
  return baseDigits ;
}

int main( int argc, char * argv[] ) {
  int n = std::atoi( argv[1] ) ;
  //we allow bases up to 36 there numbers from 3 to 36 + 2 are admitted
  while ( n <= 3 || n > 38 ) {
      std::cout << "number must be greater than 3 and smaller than 39! Re-enter!\n" ;
      std::cin >> n ;
  }
  //every number from 11 to 36 corresponds to a letter from A to Z
  //this way remainders greater than 10 can be denoted
  std::vector<std::string> alphabet( 26 ) ;
  std::iota( alphabet.begin( ) , alphabet.end( ) , 'A' ) ;
  std::vector<int> greaterBases( 26 ) ;
  std::iota( greaterBases.begin( ) , greaterBases.end( ) , 11 ) ;
  std::map<int, std::string> extendedBases ;
  for ( int i = 0 ; i < 26 ; i++ )  //26 numbers from 11 to 36
      extendedBases[ *(greaterBases.begin( ) + i)] = *(alphabet.begin( ) + i) ;
  bool isBrazilian = false ;
  for ( int i = 2 ; i < n - 1 ; i++ ) {
      std::vector<std::string> digits { toBaseDigits( n , i , extendedBases) } ;
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
