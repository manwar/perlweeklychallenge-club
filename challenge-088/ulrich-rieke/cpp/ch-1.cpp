#include <iostream>
#include <string>
#include <vector>
#include <numeric>
#include <algorithm>
#include <iterator>

int main( ) {
  std::vector<int> numbers ;
  std::string input ;
  std::cout << "please enter positive numbers ( -1 to end ) !\n" ;
  std::getline( std::cin , input ) ;
  int num = std::stoi( input ) ;
  while ( num != -1 ) {
      numbers.push_back( num ) ;
      std::getline( std::cin , input ) ;
      num = std::stoi( input ) ;
  }
  int product = std::accumulate( numbers.begin( ) , numbers.end( ) ,
    1 , std::multiplies<int>( ) ) ;
  std::vector<int> theProducts ;
  for ( int i = 0 ; i < numbers.size( ) ; i++ ) {
      theProducts.push_back( product / numbers[ i ] ) ;
  }
  std::cout << "( " ;
  std::copy( theProducts.begin( ), theProducts.end( ) ,
    std::ostream_iterator<int>( std::cout , " ") ) ;
  std::cout << ")\n" ;
  return 0 ;
