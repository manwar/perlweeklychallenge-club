#include <iostream>
#include <vector>
#include <algorithm>
#include <utility>
#include <numeric>

std::vector<std::pair<int , int>> createPairs( const std::vector<int>
      & numbers ) {
  std::vector<std::pair<int , int>> allPairs ;
  int count = 1 ;
  for ( int n : numbers ) {
      allPairs.push_back( std::make_pair( count , n )) ;
      count++ ;
  }
  return allPairs ;
}

bool isCute( const std::vector<std::pair<int , int>> & allPairs ) {
  return std::all_of( allPairs.begin( ) , allPairs.end( ) , []( const
    auto & p) { return p.first % p.second == 0 || p.second % p.first == 0 ;}) ;
}

int main( ) {
  std::cout << "Please enter an integer greater than 0 and up to 15 inclusive!\n" ;
  int number ;
  std::cin >> number ;
  std::vector<int> numbers ( number ) ;
  std::iota( numbers.begin( ) , numbers.end( ) , 1 ) ;
  int count = 0 ;
  do {
      std::vector<std::pair<int , int>> thePairs ( createPairs( numbers )) ;
      if ( isCute( thePairs )) {
    count++ ;
      }
  } while ( std::next_permutation( numbers.begin( ) , numbers.end( ))) ;
  std::cout << count << std::endl ;
  return 0 ;
}
