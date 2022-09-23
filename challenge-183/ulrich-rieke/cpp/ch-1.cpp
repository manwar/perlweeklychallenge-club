#include <utility>
#include <algorithm>
#include <vector>
#include <iostream>
#include <set>

int main( ) {
  std::cout << "Enter some numbers sequentially in pairs ( 0 to end )!\n" ;
  std::pair<int , int> input ;
  std::vector<std::pair<int , int>> allInput ;
  std::set<std::pair<int , int>> seenSoFar ;
  int a ;
  int b ;
  std::cin >> a ;
  std::cout << "second number?\n" ;
  std::cin >> b ;
  while ( b != 0 ) {
      input = std::make_pair( a , b ) ;
      allInput.push_back( input ) ;
      std::cout << "First integer:\n" ;
      std::cin >> a ;
      std::cout << "second integer ( 0 to end ):\n" ;
      std::cin >> b ;
  }
  std::cout << '[' ;
  for ( auto it = allInput.begin( ) ; it != allInput.end( ) ; ++it ) {
      if ( seenSoFar.find( *it ) == seenSoFar.end( ) ) {
    std::cout << '[' << it->first << ',' << it->second << "]," ;
    seenSoFar.insert( *it ) ;
      }
  }
  std::cout << ']' << std::endl ;
  return 0 ;
}
