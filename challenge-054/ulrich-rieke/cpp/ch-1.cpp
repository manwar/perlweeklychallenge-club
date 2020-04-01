#include <vector>
#include <iostream>
#include <algorithm>
#include <cstdlib>
#include <numeric>

int main( int argc, char * argv[] ) {
  if ( argc < 3 ) {
      std::cout << "Error! 2 integers expected!\n" ;
      return 1 ;
  }
  int limit = std::atoi( argv[1] ) ;
  int permu = std::atoi( argv[ 2 ] ) ;
  std::vector<int> numbers( limit ) ;
  std::iota( numbers.begin( ) , numbers.end( ) , 1 ) ;
  std::vector<std::vector<int> > permutations ;
  do {
      permutations.push_back( numbers ) ;
  } while ( std::next_permutation( numbers.begin( ) , numbers.end( )) ) ;
  if ( permutations.size( ) < permu ) {
      std::cout << "[]" << std::endl ;
  }
  else {
      std::cout << "[ " ;
      for ( int i : permutations[ permu - 1 ] ) {
    std::cout << i << " " ;
      }
      std::cout << "]\n" ;
  }
  return 0 ;
}
