#include <iostream>
#include <string>
#include <algorithm>
#include <cstdlib>
#include <cmath>
#include <iterator>

long parseBase( std::string numberstring , int base ) {
  static std::string allBases {"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"} ;
  long base10 = 0 ;
  long current = 1 ;
  auto start { allBases.begin( ) } ;
  std::reverse( numberstring.begin( ) , numberstring.end( ) ) ;
  for ( auto c : numberstring ) {
      auto found = std::find( allBases.begin( ) , allBases.end( ) , c ) ;
      long steps = static_cast<long>( std::distance(start , found )) ;
      base10 += steps * current ;
      current *= base ;
  }
  return base10 ;
}

bool isPerfectSquare( long number ) {
  long double root = sqrtl( static_cast<long double>( number ) ) ;
  return ( floorl( root ) == root ) ;
}


int main( int argc, char * argv[0] ) {
  int n = std::atoi( argv[1] ) ;
  std::string allBases {"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"} ;
  std::string selection { allBases.substr( 0 , n ) } ;
  reverse( selection.begin( ) , selection.end( ) ) ;
  bool found = false ;
  do {
      long theNumber = 0 ;
      if ( n == 10 )
    theNumber = std::stoul( selection ) ;
      else
    theNumber = parseBase( selection , n ) ;
      if ( isPerfectSquare( theNumber ) ) {
    std::cout << selection << std::endl ;
    found = true ;
    break ;
      }
  } while ( std::prev_permutation( selection.begin( ) , selection.end( ) )) ;
  if ( found == false )
      std::cout << "no perfect square in base " << n << " was found!\n" ;
  return 0 ;
}
