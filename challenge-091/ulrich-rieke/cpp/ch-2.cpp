#include <iostream>
#include <vector>
#include <string>

std::vector<int> enterArray( ) {
  std::cout << "Enter different integers ( -1 to end ) !\n" ;
  int i ;
  std::vector<int> myIntegers ;
  std::cin >> i ;
  while ( i != -1 ) {
      myIntegers.push_back( i )  ;
      std::cin >> i ;
  }
  return myIntegers ;
}

int main( ) {
  std::vector<int> array = enterArray( ) ;
  int current = 0 ;
  int len = array.size( ) ;
  int value = 0 ;
  int count = 1 ;
  int num = *(array.begin( )) ;
  int lastValue = num ;
  while ( current < len ) {
      current += *(array.begin( ) + current ) ;
      if ( current == len - 1 ) {
    value = 1 ;
    break ;
      }
      if ( current < len - 1 && *(array.begin( ) + current) == 0 ) {
    break ;
      }
  }
  std::cout << value << std::endl ;
  return 0 ;
}
