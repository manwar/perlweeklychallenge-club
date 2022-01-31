nclude <iostream>
#include <vector>
#include <cstdlib>
#include <algorithm>

int findDigitSum( int n ) {
  int sum = 0 ;
  while ( n != 0 ) {
      sum += (n % 10) ;
      n /= 10 ;
  }
  return sum ;
}

std::vector<int> findFibonaccis( ) {
  std::vector<int> fibos { 0 , 1 } ;
  while ( fibos.size( ) < 8 ) {
      fibos.push_back( fibos.back( ) + fibos[ fibos.size( ) - 2 ] ) ;
  }
  return fibos ;
}

int main( int argc, char * argv[] ) {
  std::vector<int> fiboDigitSums ;
  int n = std::atoi( argv[1] ) ;
  int current = -1 ;
  std::vector<int> fibonaccis = findFibonaccis( ) ;
  while ( fiboDigitSums.size( ) < n ) {
      current++ ;
      int digitSum = findDigitSum( current ) ;
      if ( std::find( fibonaccis.begin( ) , fibonaccis.end( ) , digitSum )
        != fibonaccis.end( ) )
    fiboDigitSums.push_back( current ) ;
      if ( digitSum > fibonaccis.back( ) ) {
    do {
        fibonaccis.push_back( fibonaccis.back( ) +
          fibonaccis[ fibonaccis.size( ) - 2] ) ;
    } while ( fibonaccis.back( ) < digitSum ) ;
      }
  }
  for ( int num : fiboDigitSums ) {
      std::cout << num << " " ;
  }
  std::cout << std::endl ;
  return 0 ;
}
