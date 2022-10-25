#include <iostream>

int main( ) {
  std::cout << "Please enter a positive integer x!\n" ;
  int x ;
  std::cin >> x ;
  std::cout << "Please enter a positive integer y!\n" ;
  int y ;
  std::cin >> y ;
  int count = 0 ;
  if ( x == y )
      std::cout << 1 << std::endl ;
  else {
      while ( x != y ) {
    if ( x > y )
        x -= y ;
    else
        y -= x ;
    count++ ;
      }
  }
  count++ ;
  std::cout << count << std::endl ;
  return 0 ;
}
