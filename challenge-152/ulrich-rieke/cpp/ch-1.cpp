#include <iostream>
#include <vector>
#include <algorithm>

int main( ) {
  std::vector<std::vector<int>> triangle ;
  std::vector<int> row ;
  int rows = 0 ;
  std::cout << "How many rows do you want to enter?" ;
  std::cin >> rows ;
  int number = 0 ;
  int howmany = 1 ;
  for ( int i = 0 ; i < rows; i++ ) {
      std::cout << howmany << " numbers for row " << (i + 1) << '\n' ;
      if ( howmany == 1 ) {
    std::cin >> number ;
    row.push_back( number ) ;
    triangle.push_back( row ) ;
    row.clear( ) ;
      }
      else {
    for ( int j = 0 ; j < howmany ; j++ ) {
        std::cin >> number ;
        row.push_back( number ) ;
    }
    triangle.push_back( row ) ;
    row.clear( ) ;
      }
      howmany++ ;
  }
  int pathsum = 0 ;
  for ( auto & aRow : triangle )
      pathsum += *(std::min_element( aRow.begin( ) , aRow.end( ))) ;
  std::cout << std::endl ;
  std::cout << pathsum << std::endl ;
  return 0 ;
}
