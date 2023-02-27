#include <iostream>
#include <cstdlib>
#include <vector>

int main( int argc , char * argv[] ) {
  std::vector<int> numbers ;
  for ( int i = 1 ; i < argc ; i++ ) {
      numbers.push_back( std::atoi( argv[ i ] ) ) ;
  }
  int the_max = 0 ;
  int sz = numbers.size( ) ;
  for ( int i = 0 ; i < sz - 1 ; i++ ) {
      for ( int j = i + 1 ; j < sz ; j++ ) {
    if ( numbers[ i ] != numbers[ j ] ) {
        int num =  numbers[ i ] ^ numbers[ j ] ;
        if ( num > the_max )
          the_max = num ;
    }
      }
  }
  std::cout << the_max << std::endl ;
}
