#include <iostream>

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

int leftFactorial( int n ) {
  int sum = 0 ;
  for ( int i = 0 ; i < n + 1 ; i++ )
      sum += factorial( i ) ;
  return sum ;
}

int main( ) {
  for ( int i = 0 ; i < 10 ; i++ ) {
      std::cout << leftFactorial( i ) << " " ;
  }
  std::cout << std::endl ;
  return 0 ;
}
