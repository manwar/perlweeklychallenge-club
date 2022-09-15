#include <iostream>
#include <vector>
#include <algorithm>

int main( ) {
  std::vector<int> numbers ;
  int num = 0 ;
  std::cout << "Please enter positive integers, -1 to end!\n" ;
  std::cin >> num ;
  while ( num != -1 ) {
      numbers.push_back( num ) ;
      std::cin >> num ;
  }
  int max = *std::max_element( numbers.begin( ) , numbers.end( ) ) ;
  int maxPos = 0 ;
  while ( numbers[ maxPos ] != max )
      maxPos++ ;
  std::cout << maxPos << std::endl ;
  return 0 ;
}
