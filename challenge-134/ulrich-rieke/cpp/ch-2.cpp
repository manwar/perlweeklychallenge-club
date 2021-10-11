#include <iostream>
#include <cstdlib>
#include <string>
#include <set>
#include <vector>
#include <algorithm>
#include <iterator>

int main( int argc , char * argv[ ] ) {
  int m = std::atoi( argv[ 1 ] ) ;
  int n = std::atoi( argv[ 2 ] ) ;
  int num_maxwidth = std::to_string( m * n ).length( ) + 1 ;
  int firstColWidth =  std::to_string( m ).length( ) + 2 ;
  std::cout << 'x' ;
  std::cout.width( firstColWidth - 1 ) ;
  std::cout << '|' ;
  for ( int i = 1 ; i < n + 1 ; i++ ) {
      std::cout.width( num_maxwidth ) ;
      std::cout << i ;
  }
  std::cout << '\n' ;
  for ( int i = 1 ; i < firstColWidth ; i++ )
      std::cout << '-' ;
  std::cout << '+' ;
  for ( int i = 0 ; i < num_maxwidth * n  ; i++ )
      std::cout << '-' ;
  std::cout << '\n' ;
  std::set<int> distinctTerms ;
  for ( int i = 1 ; i < m + 1 ; i++ ) {
      std::cout << i ;
      int w = std::to_string( i ).length( ) ;
      std::cout.width( firstColWidth - w ) ;
      std::cout << '|' ;
      for ( int j = 1 ; j < n + 1 ; j++ ) {
    std::cout.width( num_maxwidth ) ;
    std::cout << i * j ;
    distinctTerms.insert( i * j ) ;
      }
      std::cout << '\n' ;
  }
  std::cout << std::endl ;
  std::vector<int> terms ( distinctTerms.begin( ) , distinctTerms.end( ) ) ;
  std::sort( terms.begin( ) , terms.end( ) ) ;
  std::cout << "Distinct Terms: " ;
  std::copy( terms.begin( ) , terms.end( ) , std::ostream_iterator<int>(
        std::cout , " " )) ;
  std::cout << '\n' ;
  std::cout << "Count: " << terms.size( ) << std::endl ;
  return 0 ;
}
