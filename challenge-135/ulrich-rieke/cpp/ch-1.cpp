#include <iostream>
#include <string>
#include <regex>

int main( int argc, char * argv[] ) {
  std::string input { argv[ 1 ] } ;
  std::string checkRegex( "(^[+-]*\\d+$)" ) ;
  std::regex checkReg( checkRegex ) ;
  while ( ! std::regex_match( input , checkReg ) ) {
      std::cout << "Input should consist of possible signs and digits only!\n" ;
      std::getline( std::cin , input ) ;
  }
  int len = input.length( ) ;
  if ( ( len == 4 ) ) {
      std::string start { input.substr( 0 , 1 ) } ;
      if ( (start == "+") || ( start == "-" ) )
    std::cout << input.substr( 1 ) << std::endl ;
  }
  else {
      if ( len % 2 == 0 )
    std::cout << "even number of digits" << std::endl ;
      if ( ( len < 3 ) && (  len % 2 != 0 ))
    std::cout << "too short" << std::endl ;
      if ( ( len % 2 != 0 ) && ( len > 3 ) )
    std::cout << input.substr( ( len - 3 ) / 2 , 3 ) << std::endl ;
  }
  return 0 ;
}
