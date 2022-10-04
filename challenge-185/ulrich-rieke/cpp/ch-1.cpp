#include <iostream>
#include <string>

int main( ) {
  std::cout << "Please enter a MAC address in the form hhhh.hhhh.hhhh!\n" ;
  std::string address ;
  std::getline( std::cin , address ) ;
  int pos = 0 ;
  std::string output ;
  while ( pos < address.length( ) - 2 ) {
      output.append( address.substr( pos , 2 )) ;
      output.append( ":" ) ;
      pos += 2 ;
      if ( address.substr( pos , 1 ) == "." )
    pos++ ;
  }
  //take the output substr because we want to leave out the final ':'
  std::cout << output.substr(0 , output.length( ) - 1 ) << std::endl ;
  return 0 ;
}
