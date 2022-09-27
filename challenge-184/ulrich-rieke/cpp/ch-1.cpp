#include <vector>
#include <iostream>
#include <string>

int main( ) {
  std::vector<std::string> input ;
  std::cout << "Please enter a string, starting with 2 digits and then 4 letters!\n" ;
  std::cout << "enter <return> to end!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  while ( !line.empty( ) ) {
      input.push_back( line ) ;
      std::getline( std::cin , line ) ;
  }
  int count = 0 ;
  std::vector<std::string> output ;
  for ( auto it = input.begin( ) ; it != input.end( ) ; ++it ) {
      std::string newWord ;
      if ( count < 10 ) {
    newWord = "0" + std::to_string( count ) + it->substr( 2 ) ;
      }
      if ( count > 9 ) {
    newWord = std::to_string( count ) + it->substr( 2 ) ;
      }
      output.push_back( newWord ) ;
      count++ ;
  }
  std::cout << '(' ;
  for ( const auto & w : output ) {
      std::cout << w ;
      if ( w != output.back( ) )
    std::cout << ", " ;
  }
  std::cout << ')' << std::endl ;
  return 0 ;
}
