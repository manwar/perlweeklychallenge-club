#include <iostream>
#include <vector>
#include <cstdlib>
#include <algorithm>

int main( int argc, char* argv[] ) {
  std::vector<int> numbers ;
  for ( int i = 1 ; i < argc ; i++ )
      numbers.push_back( std::atoi( argv[i] ) ) ;
  auto last = std::unique( numbers.begin( ) , numbers.end( ) ) ;
  numbers.erase( last, numbers.end( ) ) ;
  std::sort( numbers.begin( ) , numbers.end( ) ) ;
  if ( numbers.size( ) < 3 )
      std::cout << numbers.back( ) ;
  else
      std::cout << numbers[ numbers.size( ) - 3 ] ;
  std::cout << std::endl ;
  return 0 ;
}
