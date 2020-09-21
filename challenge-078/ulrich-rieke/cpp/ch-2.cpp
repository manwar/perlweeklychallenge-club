#include <vector>
#include <iostream>

std::vector<int> enterArray( ) {
  std::cout << "Enter integers ( -1 to end ) !\n" ;
  int i ;
  std::vector<int> myIntegers ;
  std::cin >> i ;
  while ( i != -1 ) {
      myIntegers.push_back( i )  ;
      std::cin >> i ;
  }
  return myIntegers ;
}

std::vector<int> leftRotate( int index , const std::vector<int> & array ) {
  std::vector<int> rotated ;
  for ( auto i = array.begin( ) + index ; i != array.end( ) ; i++ )
      rotated.push_back( *i ) ;
  for ( auto i = array.begin( ) ; i != array.begin( ) + index ; i++ )
      rotated.push_back( *i ) ;
  return rotated ;
}

int main( ) {
  std::vector<int> numbers = enterArray( ) ;
  std::cout << "Enter indices into the number array!" ;
  std::cout << "(between 0 and " << numbers.size( ) - 1 << " )!\n" ;
  std::vector<int> indices = enterArray( ) ;
  std::vector<int> rotated ;
  for ( int i : indices ) {
      rotated = leftRotate( i , numbers ) ;
      std::cout << "[ " ;
      for ( int j : rotated ) {
    std::cout << j << " " ;
      }
      std::cout << " ]\n" ;
      rotated.clear( ) ;
  }
  return 0 ;
}
