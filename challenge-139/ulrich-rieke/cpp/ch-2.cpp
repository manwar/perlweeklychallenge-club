#include <iostream>
#include <string>
#include <vector>
#include <cmath>

bool isPrime( int number ) {
  int stop =  std::sqrt( static_cast<double>( number ) ) ;
  for ( int i = 2 ; i <= stop ; ++i )
      if ( number % i == 0 )
    return false ;
  return true ;
}

std::string divideByHand( int n ) {
  std::string quotientstring {"0."} ;
  int number = 10 ;
  int remainder = 0 ;
  while ( quotientstring.length( ) < 2 * ( n - 1 ) + 2 ) {
      int quot = number / n ;
      quotientstring.append( std::to_string( quot ) ) ;
      remainder = number - quot * n ;
      if ( remainder == 0 )
    break ;
      else
    number = remainder * 10 ;
  }
  return quotientstring ;
}

int main( ) {
  std::vector<int> allPrimes ;
  int current = 2 ;
  while ( allPrimes.size( ) < 5 ) {
      std::string quotient { divideByHand( current ) } ;
      std::string afterPoint { quotient.substr( 2 ) } ;
      if ( afterPoint.length( ) == 2 * ( current - 1 ) ) {
    int half = afterPoint.length( ) / 2 ;
    if ( afterPoint.substr( 0 , half ) == afterPoint.substr( half ) ) {
        allPrimes.push_back( current ) ;
    }
      }
      do {
    current++ ;
      } while ( ! isPrime( current ) ) ;
  }
  for ( int d : allPrimes ) {
      if ( d != allPrimes.back( ) )
    std::cout << d << ", " ;
      else
    std::cout << d << std::endl ;
  }
  return 0 ;
}
