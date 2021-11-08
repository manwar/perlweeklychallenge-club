#include <iostream>
#include <cstdlib>

int main( int argc, char * argv[] ) {
  int n = std::atoi( argv[ 1 ] ) ;
  int current = 0 ;
  while ( current * current < n )
      current++ ;
  if ( current * current == n )
      std::cout << current << std::endl ;
  else
      std::cout << --current << std::endl ;
}
