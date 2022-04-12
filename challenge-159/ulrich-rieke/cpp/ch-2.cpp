#include <iostream>
#include <vector>
#include <set>
#include <cstdlib>

//the smallest current divisor of a number is a prime number
std::vector<int> primeDecompose( int n ) {
  std::vector<int> primes ;
  int current = 2 ;
  while ( n != 1 ) {
      if ( n % current == 0 ) {
    primes.push_back( current ) ;
    n /= current ;
      }
      else
    current++ ;
  }
  return primes ;
}

int main( int argc, char * argv[] ) {
  int n = std::atoi( argv[1] ) ;
  while ( n <= 0 ) {
      std::cout << "Please enter a number greater than 0!\n" ;
      std::cin >> n ;
  }
  std::vector<int> primes { primeDecompose( n ) } ;
  std::set<int> uniqueNums( primes.begin( ) , primes.end( ) ) ;
  int pl = primes.size( ) ;
  int ul = uniqueNums.size( ) ;
  if ( pl == ul ) {
      if ( pl % 2 == 0 )
    std::cout << 1 ;
      else
    std::cout << -1 ;
  }
  else
      std::cout << 0 ;
  std::cout << std::endl ;
  return 0 ;
}
