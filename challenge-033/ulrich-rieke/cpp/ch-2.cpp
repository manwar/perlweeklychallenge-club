#include <iostream>

int main( ) {
  std::cout.width( 4 ) ;
  std::cout << "x|" ;
  for ( int i = 1 ; i < 12 ; i++ ) {
      std::cout.width( 4 ) ;
      std::cout << i ;
  }
  std::cout << std::endl ;
  for ( int i = 0 ; i < 48 ; i++ )
      std::cout << '-' ;
  std::cout << std::endl ;
  for ( int i = 1 ; i < 12 ; i++ ) {
      std::cout.width( 3 ) ;
      std::cout << i << '|' ;
      if ( i > 1 ) {
    for ( int j = 0 ; j < (i - 1 ) * 4 ; j++ ) {
        std::cout << ' ' ;
    }
      }
      for ( int mult = i ; mult < 12 ; mult++ ) {
    std::cout.width( 4 ) ;
    std::cout << i * mult ;
      }
      std::cout << std::endl ;
  }
}
