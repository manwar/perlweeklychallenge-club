
#include <iostream>
#include <vector>

std::vector<int> enterRow( ) {
  std::cout << "Enter a row , 0 to end the row!\n" ;
  std::vector<int> row ;
  int number ;
  std::cin >> number ;
  while ( number != 0 ) {
      row.push_back( number ) ;
      std::cin >> number ;
  }
  return row ;
}

std::vector<std::vector<int>> enterArray( ) {
  std::cout << "How many lines do you want to enter?\n" ;
  int number ;
  std::cin >> number ;
  std::vector<int> row ;
  std::vector<std::vector<int>> array ;
  for ( int i = 0 ; i < number ; i++ ) {
      std::cout << "Next line!\n" ;
      row = enterRow( ) ;
      array.push_back( row ) ;
  }
  return array ;
}

int main( ) {
  int currentIndex = 0 ;
  int sum = 0 ;
  std::vector<std::vector<int>> array = enterArray( ) ;
  int len = array.size( ) ;
  for ( int i = 0 ; i < len ; i++ ) {
      std::vector<int> row { *(array.begin( ) + i) } ;
      if ( row.size( ) == 1 )
    sum += *(row.begin( ) ) ;
      else {
    sum += std::min( *(row.begin() + currentIndex) , *(row.begin( ) +
          currentIndex + 1 ) ) ;
    if ( row[ currentIndex + 1 ] < row[ currentIndex ] )
        currentIndex++ ;
      }
  }
  std::cout << sum << std::endl ;
  return 0 ;
}
