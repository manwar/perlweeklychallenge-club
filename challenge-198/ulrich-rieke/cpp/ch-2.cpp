#include <iostream>
#include <cstdlib>
#include <cmath>

bool isPrime( int number ) {
  if ( number < 2 ) {
      return false ;
  }
  int stop =  std::sqrt( static_cast<double>( number ) ) ;
  for ( int i = 2 ; i <= stop ; ++i )
      if ( number % i == 0 )
        return false ;
  return true ;
}

int main( int argc, char * argv[] ) {
  int number = std::atoi( argv[1] ) ;
  int primcount = 0 ;
  for ( int i = 0 ; i < number ; i++ ) {
      if ( isPrime( i ) )
    primcount++ ;
  }
  std::cout << primcount << std::endl ;
  return 0 ;
}
