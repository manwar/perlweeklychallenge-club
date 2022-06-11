#include <iostream>
#include <vector>
#include <numeric>

//make a list from a given one adding up all the numbers except the first one
std::vector<int> createList( const std::vector<int> & input ) {
  std::vector<int> output ;
  for ( int i = 1 ; i < input.size( ) ; i++ ) {
      output.push_back( std::accumulate( input.begin( ) + 1 , input.begin( ) +
          i + 1 , 0 )) ;
  }
  return output ;
}

int main( ) {
  std::cout << "Please enter integer numbers , 0 to end!\n" ;
  int number ;
  std::vector<int> numbers ;
  std::cin >> number ;
  while ( number != 0 ) {
      numbers.push_back( number ) ;
      std::cout << "Next number!\n" ;
      std::cin >> number ;
  }
  std::vector<int> output { numbers } ;
  do {
      output = createList( output ) ;//repeat making a list
  } while ( output.size( ) != 1 ) ; //until we have only one number left
  std::cout << *(output.begin( ) ) << std::endl ;
  return 0 ;
}
