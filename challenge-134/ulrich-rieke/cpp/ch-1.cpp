#include <iostream>
#include <string>
#include <vector>
#include <map>

bool isPanDigital( long num ) {
  std::map<std::string , int> digitCount ;
  std::string numberstring( std::to_string( num ) ) ;
  for ( int i = 0 ; i < numberstring.length( ) ; i++ )
      digitCount[ numberstring.substr( i , 1 )]++ ;
  return digitCount.size( ) == 10 ;
}

int main( ) {
  std::string start { "1023456789" } ;
  std::vector<long> panDigitals ;
  long current = std::stol( start ) ;
  panDigitals.push_back( current ) ;
  while ( panDigitals.size( ) != 5 ) {
      current++ ;
      if ( isPanDigital( current ) )
    panDigitals.push_back( current ) ;
  }
  for ( auto n : panDigitals )
      std::cout << n << " " ;
  std::cout << std::endl ;
  return 0 ;
}
