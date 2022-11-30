#include <iostream>
#include <string>
#include <algorithm>
#include <cstdlib>
#include <vector>

std::string toBinaryString( int n , int len ) {
  std::string binary ;
  while ( n != 0 ) {
      binary.append( std::to_string( n % 2 )) ;
      n /= 2 ;
  }
  while ( binary.length( ) < len )
      binary.append( "0" ) ;
  std::reverse( binary.begin( ) , binary.end( ) ) ;
  return binary ;
}

int main( int argc , char * argv[] ) {
  if ( argc != 2 ) {
      std::cerr << "usage : <programname> <number of ones>!\n" ;
      return 1 ;
  }
  else {
      int n = std::atoi( argv[ 1 ] ) ;
      int sum = 0 ;
      int multiplier = 1 ;
      for ( int i = 0 ; i < n ; i++ ) {
    sum += multiplier ;
    multiplier *= 2 ;
      }
      std::vector<std::string> allBinaries ;
      for ( int i = 0 ; i < sum + 1 ; i++ ) {
    allBinaries.push_back( toBinaryString( i , n )) ;
      }
      for ( const auto & str : allBinaries ) {
    std::cout << str ;
    if ( str != allBinaries.back( ) )
        std::cout << ", " ;
      }
      std::cout << std::endl ;
      return 0 ;
  }
}
