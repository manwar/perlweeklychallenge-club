#include <vector>
#include <iostream>
#include <algorithm>

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
  std::vector<int> leaders ;
  std::vector<int> myIntegers = enterArray( ) ;
  int size = myIntegers.size( ) ;
  for ( auto i = myIntegers.begin( ) ; i != (myIntegers.begin( ) + size
      - 1 ) ; i++ ) {
    if ( *i > *std::max_element( i + 1 , myIntegers.end( ) ) ) {
        leaders.push_back( *i ) ;
    }
  }
  leaders.push_back( *(myIntegers.begin( ) + size - 1) ) ;
  std::cout << "[ " ;
  for ( int num : leaders ) {
      std::cout << num << " " ;
  }
  std::cout << "]\n" ;
  return 0 ;
}
