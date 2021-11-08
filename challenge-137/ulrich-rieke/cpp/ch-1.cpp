#include <iostream>
#include <vector>

int findWeekday ( int year ) {
  return (( year + year / 4 - year / 100 + year / 400 ) % 7 ) ;
}

int main( ) {
  std::vector<int> longYears ;
  for ( int y = 1900 ; y < 2101 ; y++ )
      if ( findWeekday( y ) == 4 || findWeekday( y - 1 ) == 3 )
    longYears.push_back( y ) ;
  int current = 0 ;
  for ( int i : longYears ) {
      if ( current < longYears.size( ) -1 )
    std::cout << i << ", " ;
      else
    std::cout << i << std::endl ;
      current++ ;
      if ( current % 5 == 0 )
    std::cout << std::endl ;
  }
  return 0 ;
}
