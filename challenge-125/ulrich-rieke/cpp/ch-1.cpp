#include <iostream>
#include <cstdlib>
#include <algorithm>
#include <set>
#include <vector>

int main( int argc , char * argv[] ) {
  int n = std::atoi( argv[ 1 ] ) ;
  if ( n > 20 ) {
      std::cerr << "Number entered should be an integer up to 20!" ;
      exit( EXIT_FAILURE ) ;
      return 1 ;
  }
  else {
      std::set<std::vector<int> > triples ;
      for ( int i = 1 ; i < 101 ; i++ ) {
    for ( int j = 1 ; j < 101 ; j++ ) {
        for ( int k = 1 ; k < 101 ; k++ ) {
          if ( n == i || n == j || n == k ) {
          if ( i * i + j * j == k * k ) {
            std::vector<int> triple { i , j , k } ;
            std::sort( triple.begin( ) , triple.end( ) ) ;
            triples.insert( triple ) ;
          }
          }
        }
    }
      }
      if ( ! triples.empty( ) ) {
    for ( auto & vec : triples ) {
        std::cout << '(' ;
        for ( auto num : vec ) {
          std::cout << num << ' ' ;
        }
        std::cout << ")\n" ;
    }
      }
      else {
    std::cout << -1 << std::endl ;
      }
      return 0 ;
  }
}
