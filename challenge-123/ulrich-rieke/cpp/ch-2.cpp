#include <string>
#include <iostream>
#include <utility>
#include <vector>
#include <cmath>
#include <set>
using Point = std::pair<int, int> ;

double computeDistance( const Point & p1 , const Point & p2 ) {
  return std::sqrt( std::pow( static_cast<double>(p2.first - p1.first) ,
        2.0) + std::pow( static_cast<double>(p2.second - p1.second) ,
          2.0 ) ) ;
}

int main( ) {
  std::vector<Point> points ;
  int num = 0 ;
  for ( int i = 0 ; i < 4 ; i++ ) {
      Point p { 0 , 0 } ;
      std::cout << "For " << i + 1 << ". point, enter x: \n" ;
      std::cin >> num ;
      p.first = num ;
      std::cout << " and y: \n" ;
      std::cin >> num ;
      p.second = num ;
      points.push_back( p ) ;
  }
  std::set<double> distances ;
  for ( int i = 0 ; i < 3 ; i++ ) {
      distances.insert( computeDistance( points[ i ] , points[ i++ ] )) ;
  }
  distances.insert( computeDistance( points[ 0 ] , points[ 3 ] )) ;
  std::set<double> diagonals ;
  diagonals.insert( computeDistance( points[ 0 ] , points[ 2 ] )) ;
  diagonals.insert( computeDistance( points[ 1 ] , points[ 3 ] )) ;
  if ( distances.size( ) == 1 && diagonals.size( ) == 1 ) {
      std::cout << std::endl ;
      std::cout << 1 << std::endl ;
  }
  else {
      std::cout << std::endl ;
      std::cout << 0 << std::endl ;
  }
  return 0 ;
}
