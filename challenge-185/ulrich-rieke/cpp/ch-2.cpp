#include <iostream>
#include <string>
#include <cctype>
#include <algorithm>
#include <vector>

std::string substitute( const std::string & word ) {
  std::string output ;
  int count = 0 ;
  int pos = 0 ;
  while ( count < 4 ) {
      if (std::isalnum( static_cast<int>(word[ pos ] )) != 0 ) {
    output.append( "x") ;
    pos++ ;
    count++ ;
      }
      else {
    output.append( word.substr( pos, 1 )) ;
    pos++ ;
      }
  }
  output.append( word.substr( pos )) ;
  return output ;
}

int main( ) {
  std::cout << "Please enter codes with a minimum length of 4!\n" ;
  std::cout << "Enter an empty string to end!\n" ;
  std::vector<std::string> allInput ;
  std::string line ;
  std::getline( std::cin , line ) ;
  while ( line.length( ) > 0 ) {
      allInput.push_back( line ) ;
      std::getline( std::cin , line ) ;
  }
  std::transform( allInput.begin( ) , allInput.end( ) , allInput.begin( ),
    substitute ) ;
  for ( auto & s : allInput ) {
      std::cout << s ;
      if ( s != allInput.back( ) )
    std::cout << " , " ;
  }
  std::cout << std::endl ;
  return 0 ;
}
