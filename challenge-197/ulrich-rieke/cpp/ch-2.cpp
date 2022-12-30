#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <utility>
#include <map>

bool myCondition( const std::vector<int> & numbers ) {
  int len = numbers.size( ) ;
  if ( len == 3 ) {
      return ( (numbers[0] < numbers[1]) && ( numbers[1] > numbers[2] ) ) ;
  }
  if ( len > 3 ) {
      for ( int i = 0 ; i < len - 1  ; i++ ) {
    if ( i % 2 == 0 ) {
        if ( ! (numbers[ i ] < numbers[ i + 1 ]) ) {
          return false ;
        }
    }
    else {
        if ( ! (numbers[ i ] > numbers[ i + 1 ] ) ) {
          return false ;
        }
    }
      }
  }
  return true ;
}

void printOut( const std::vector<int> & nums ) {
  std::cout << '(' ;
  for ( int i : nums ) {
      std::cout << i << ' ' ;
  }
  std::cout << ')' << std::endl ;
}

int main( ) {
  std::cout << "Please enter at least 3 integers, 0 to end!\n" ;
  std::vector<int> numbers ;
  int num ;
  std::cin >> num ;
  while ( num != 0  ) {
      numbers.push_back( num ) ;
      std::cin >> num ;
  }
  while ( numbers.size( ) < 3 ) {
      std::cout << "You should enter at least 3 numbers!\n!" ;
      std::cin >> num ;
      numbers.push_back( num ) ;
  }
  std::map<int , int> frequencies ;
  for ( int i : numbers ) {
      frequencies[i]++;
  }
  std::vector<std::pair<int , int>> thePairs ( frequencies.begin( ) ,
    frequencies.end( ) ) ;
  std::pair<int , int> maxPair = *std::max_element( thePairs.begin( ) ,
    thePairs.end( ) , []( const auto & p1 , const auto & p2 ) {
    return p1.second > p2.second ; } ) ;
  if ( maxPair.second >= numbers.size( ) - 1 ) {
      std::cout << "No wiggling possible!\n" ;
  }
  else {
      sort( numbers.begin( ) , numbers.end( ) ) ;
      while ( std::next_permutation( numbers.begin( ) , numbers.end( ))) {
    if ( myCondition( numbers ) ) {
        printOut( numbers ) ;
    }
      }
  }
  return 0 ;
}
