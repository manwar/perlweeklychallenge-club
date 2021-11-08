#include <iostream>
#include <string>
#include <regex>
#include <cctype>
#include <algorithm>
#include <array>

int main( int argc , char * argv[ ] ) {
  std::string sedol { argv[ 1 ] } ;
  bool valid = false ;
  if ( sedol.length( ) != 7 ) {
      std::cout << 0 << std::endl ;
      return 1 ;
  }
  std::transform( sedol.begin( ) , sedol.end( ) , sedol.begin( ) ,
    toupper ) ;
  std::string checkReg ("(^\\w+$)" ) ;
  std::regex checkRegex( checkReg ) ;
  std::string anotherCheck ("([AEIOU])") ;
  std::regex vowelCheck( anotherCheck ) ;
  if ( (! ( std::regex_match( sedol , checkRegex ))) ||
    ( std::regex_match( sedol , vowelCheck ) ) ) {
      std::cout << 0 << std::endl ;
      return 2  ;
  }
  std::array<int, 7> weights {{ 1, 3 , 1 , 7 , 3 , 9 , 1 }} ;
  int sum = 0 ;
  for ( int i = 0 ; i < 6 ; i++ ) {
      int value = static_cast<int>( sedol[ i ] ) ;
      if ( isupper( value )) {
    sum += (value - 55) * weights[ i ]  ;
      }
      else {
    int value = std::stoi( sedol.substr( i , 1 ) ) ;
    sum += value * weights[ i ] ;
      }
  }
  std::string letterStr {sedol.substr( 6 , 1 )} ;
  if ( std::stoi( letterStr ) == ( (10 - ( sum % 10 )) % 10 )) {
      std::cout << 1 << std::endl ;
  }
  else
      std::cout << 0 << std::endl ;
  return 0 ;
}
