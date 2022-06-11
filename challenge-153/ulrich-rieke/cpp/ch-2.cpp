#include <iostream>
#include <cstdlib>
#include <vector>
#include <algorithm>
#include <numeric>

int factorial( int num ) {
  if ( num == 0 ) {
      return 1 ;
  }
  else {
      int fac = 1 ;
      for ( int i = 1 ; i < num + 1 ; i++ )
    fac *= i ;
      return fac ;
  }
}

int main( int argc, char* argv[] ) {
  int n = std::atoi( argv[1] ) ;
  int c = n ; //we are "destroying" n in the next lines
  std::vector<int> digits ;
  while ( n != 0 ) {
      digits.push_back( n % 10 ) ;
      n /= 10 ;
  }
  std::transform( digits.begin( ) , digits.end( ) , digits.begin( ) ,
    factorial ) ;
  if ( std::accumulate( digits.begin( ) , digits.end( ) , 0 ) == c )
      std::cout << 1 << std::endl ;
  else
      std::cout << 0 << std::endl ;
  return 0 ;
}
