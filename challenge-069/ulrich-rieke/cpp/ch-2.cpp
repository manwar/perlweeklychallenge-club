#include <string>
#include <iostream>
#include <algorithm>
#include <iterator>

std::string mySwitch( const std::string & num ) {
  std::string switched ;
  std::string letter ;
  for ( int i = 0 ; i < num.length( ) ; i++ ) {
      if ( num.substr( i , 1 ) == "0" )
    letter = "1" ;
      else
    letter = "0" ;
      switched.append( letter ) ;
  }
  return switched ;
}

int main( ) {
  std::string current( "0" ) ;
  int n = 1 ;
  while ( n < 30 ) {
      std::string reversed ;
      std::reverse_copy( current.begin( ) , current.end( ) ,
        std::back_inserter( reversed ) ) ;
      current += "0"  ;
      current += mySwitch( reversed ) ;
      n++ ;
  }
  std::cout << "S30 is " << current << std::endl ;
  return 0 ;
}
