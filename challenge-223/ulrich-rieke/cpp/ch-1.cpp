#include <iostream>
#include <cmath>

bool is_Prime( int n ) {
  double stop = sqrt( static_cast<double>( n ) ) ;
  int limit = static_cast<int>( floor( stop ) ) ;
  for ( int i = 2 ; i < limit + 1 ; i++ ) {
      if ( n % i == 0 )
        return false ;
  }
  return true ;
}

int main( ) {
  std::cout << "Please enter a positive integer!\n" ;
  int num ;
  std::cin >> num ;
  int total = 0 ;
  for ( int i = 2 ; i < num + 1 ; i++ ) {
      if ( is_Prime( i ) )
    total++ ;
  }
  std::cout << total << std::endl ;
  return 0 ;
}
