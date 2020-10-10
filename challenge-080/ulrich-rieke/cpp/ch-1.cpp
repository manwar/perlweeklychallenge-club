#include <vector>
#include <iostream>
#include <algorithm>

std::vector<int> enterArray ( int limit ) {
  std::vector<int> numbers ;
  int num ;
  while ( numbers.size( ) < limit ) {
      std::cin >> num ;
      numbers.push_back( num ) ;
  }
  return numbers ;
}

int main( ) {
  std::cout << "How many numbers do you want to enter ?\n" ;
  int num ;
  std::cin >> num ;
  std::cout << "Enter " << num << " numbers!\n" ;
  std::vector<int> numbers = enterArray( num ) ;
  std::vector<int> positives ;
  for ( int i : numbers ) {
      if ( i > 0 )
    positives.push_back( i ) ;
  }
  std::sort( positives.begin( ) , positives.end( ) ) ;
  int current = 1 ;
  auto found = std::find( positives.begin( ) , positives.end( ) , current ) ;
  while ( found != positives.end( ) ) {
      current++ ;
      found = std::find( positives.begin( ) , positives.end( ) , current ) ;
  }
  std::cout << current << std::endl ;
  return 0 ;
}
