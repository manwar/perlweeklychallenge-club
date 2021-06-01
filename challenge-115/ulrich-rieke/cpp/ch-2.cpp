#include <list>
#include <iostream>
#include <algorithm>
#include <cmath>

bool isEven( int i ) {
  return (i % 2 == 0) ;
}

int makeIntFromList( const std::list<int> & my_list ) {
  double sum = 0.0 ;
  int size = my_list.size( ) ;
  int i = size - 1 ;
  for ( int num : my_list ) {
      sum += num * std::pow( 10.0 , static_cast<double>( i ) ) ;
      i-- ;
  }
  int number = static_cast<int>( sum ) ;
  return number ;
}

int main( ) {
  std::cout << "Enter positive integers, -1 to end!\n" ;
  int input ;
  std::list<int> numbers ;
  std::cin >> input ;
  while ( input != -1 ) {
      numbers.push_back( input ) ;
      std::cout << "Next number!\n" ;
      std::cin >> input ;
  }
  if ( std::none_of( numbers.begin( ) , numbers.end( ) , isEven ) ) {
      std::cout << "An even number can't be formed!\n" ;
      return 1 ;
  }
  numbers.sort( ) ;
  auto found = std::find_if( numbers.begin( ) , numbers.end( ) ,
    isEven ) ;
  int smallestEven = *found ;
  numbers.erase( found ) ;
  numbers.reverse( ) ;
  numbers.push_back( smallestEven ) ;
  std::cout << makeIntFromList( numbers ) << std::endl ;
  return 0 ;
}
