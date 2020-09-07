#include <vector>
#include <iostream>
#include <algorithm>

std::vector<std::vector<int>> createGroups( const std::vector<int> &
      numbers , int groupwidth ) {
  std::vector<std::vector<int>> groups ;
  int len = numbers.size( ) ;
  std::vector<int> group ;
  for ( int start = 0 ; start < len - groupwidth + 1 ; start++ ) {
      int current = start ;
      while ( current < (start + groupwidth) ) {
    group.push_back( *(numbers.begin( ) + current) ) ;
    current++ ;
      }
      groups.push_back( group ) ;
      group.clear( ) ;
  }
  return groups ;
}

void printArray( const std::vector<int> & array ) {
  int maximum = *std::max_element( array.begin( ) , array.end( ) ) ;
  int len = array.size( ) ;
  int current = maximum ;
  while ( current > 0 ) {
      std::cout << current ;
      for ( int i = 0 ; i < len ; i++ ) {
    if ( array[ i ] >= current )
        std::cout << " #" ;
    else
        std::cout << "  " ;
      }
      std::cout << '\n' ;
      current-- ;
  }
  for ( int i = 0 ; i < len + 1 ; i++ ) {
      std::cout << "- " ;
  }
  std::cout << '\n' ;
  std::cout << "  " ;
  for ( int num : array )
      std::cout << num << ' ' ;
  std::cout << '\n' ;
}

std::vector<int> enterArray( ) {
  std::cout << "Enter numbers ( 0 to end ) !\n" ;
  std::vector<int> array ;
  int num ;
  std::cin >> num ;
  while ( num != 0 ) {
      array.push_back( num ) ;
      std::cin >> num ;
  }
  return array ;
}

int main( ) {
  std::vector<int> array = enterArray( ) ;
  std::vector<std::vector<int>> allNeighbouringGroups ;
  int len = array.size( ) ;
  for ( int w = 2 ; w < len ; w++ ) {
      std::vector<std::vector<int>> groups( createGroups( array, w ) ) ;
      for ( const auto & myGroup : groups ) {
    allNeighbouringGroups.push_back( myGroup ) ;
      }
  }
  std::vector<int> areas ;
  for ( const auto & myGroup : allNeighbouringGroups ) {
      areas.push_back( *std::min_element( myGroup.begin( ) , myGroup.end( ))
        * myGroup.size( ) ) ;
  }
  int totalMax = std::max( *std::max_element( areas.begin( ) , areas.end( ) ),
    *std::min_element( array.begin( ) , array.end( ) ) * len ) ;
  std::cout << "maximum rectangle area is " << totalMax << " !\n" ;
  std::cout << std::endl ;
  printArray( array ) ;
  return 0 ;
}
