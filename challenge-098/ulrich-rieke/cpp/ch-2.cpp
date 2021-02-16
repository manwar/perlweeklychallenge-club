#include <list>
#include <iostream>
#include <iterator>
#include <string>
#include <algorithm>
#include <vector>
#include <cstdlib>
#include <iterator>

std::list<int> enterArray( ) {
  std::vector<int> numbers ;
  std::cout << "Enter numbers, e to end!\n" ;
  std::string input ;
  std::getline( std::cin , input ) ;
  while ( input != "e" ) {
      numbers.push_back( std::stoi( input ) ) ;
      std::getline( std::cin , input ) ;
  }
  std::sort( numbers.begin( ) , numbers.end( ) ) ;
  //conversion to list in order to apply unique
  std::list<int> nums( numbers.begin( ) , numbers.end( ) ) ;
  nums.unique( ) ;
  return nums ;
}

int main( int argc, char * argv[ 0 ] ) {
  if ( argc != 2 ) {
      std::cerr << "Error! syntax <challenge098_2> <number to insert>!\n" ;
      return 1 ;
  }
  std::list<int> numbers = enterArray( ) ;
  int n = std::atoi( argv[ 1 ] ) ;
  //the algorithm lower_bound precisely does what is required here
  //inserting a number into an array without disturbing the order
  auto insertPlace = std::lower_bound( numbers.begin( ) , numbers.end( ) , n ) ;
  std::cout << static_cast<int>( std::distance( numbers.begin( ) , insertPlace ) ) ;
  std::cout << '\n' ;
  return 0 ;
}
