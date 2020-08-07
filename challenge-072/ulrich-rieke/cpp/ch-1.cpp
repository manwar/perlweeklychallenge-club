#include <vector>
#include <algorithm>
#include <numeric>
#include <cstdlib>
#include <iostream>

int main( int argc, char * argv[] ) {
  int n = std::atoi( argv[ 1 ] ) ;
  std::vector<int> numbers( n ) ;
  std::iota( numbers.begin( ) , numbers.end( ) , 1 ) ;
  int faculty = std::accumulate( numbers.begin( ) , numbers.end( ) , 1 ,
    std::multiplies<int>( ) ) ;
  int i = 0 ;
  while ( faculty % 10 == 0 ) {
      i++ ;
      faculty /= 10 ;
  }
  std::cout << "There are " << i << " zeroes at the end of " << n << "!\n" ;
  return 0 ;
}
