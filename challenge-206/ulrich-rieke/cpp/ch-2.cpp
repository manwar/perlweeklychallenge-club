#include <iostream>
#include <vector>
#include <numeric>
#include <cstdlib>
#include <algorithm>

bool is_valid( const std::vector<int> & positions ) {
  int len = positions.size( ) ;
  int i = 0 ;
  while ( i != len ) {
      if ( positions[ i ] > positions[ i + 1 ] )
    return false ;
      else
    i += 2 ;
  }
  return true ;
}

int main( int argc , char* argv[] ) {
  if (  argc == 1  || argc % 2 != 1 ) {
      std::cerr << "Please enter an even number of arguments on the command line!\n" ;
      return 2 ;
  }
  else {
      std::vector<int> numbers ;
      for ( int i = 1 ; i < argc ; i++ ) {
    numbers.push_back( std::atoi( argv[ i ] )) ;
      }
      int len = numbers.size( ) ;
      std::vector<int> positions( len ) ;
      std::iota( positions.begin( ) , positions.end( ) , 0 ) ;
      int maximum = 0 ;
      while ( std::next_permutation( positions.begin( ) , positions.end( ) ) ) {
    if ( is_valid( positions ) ) {
        std::vector<int> minima ;
        int i = 0 ;
        while ( i != len ) {
          minima.push_back( std::min( numbers[ *(positions.begin( ) + i) ] ,
            numbers[ *(positions.begin( ) + i + 1 ) ] ) ) ;
          i += 2 ;
        }
        int sum = std::accumulate( minima.begin( ) , minima.end( ) , 0 ) ;
        if ( sum > maximum )
          maximum = sum ;
    }
      }
      std::cout << maximum << std::endl ;
      return 0 ;
  }
}
