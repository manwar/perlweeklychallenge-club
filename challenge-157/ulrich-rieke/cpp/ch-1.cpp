#include <iostream>
#include <vector>
#include <cmath>
#include <numeric>
#include <algorithm>

int main( ) {
  std::vector<int> numbers ;
  std::cout << "Please enter integers, negative number to end entry!\n" ;
  int num ;
  std::cin >> num ;
  while ( num >= 0 ) {
      numbers.push_back( num ) ;
      std::cin >> num ;
  }
  int l = numbers.size( ) ;
  double am =  std::accumulate( numbers.begin( ) , numbers.end( ) ,
        0 ) / static_cast<double>(l)  ;
  int prod =  std::accumulate( numbers.begin( ) , numbers.end( ) , 1 ,
        std::multiplies<int>() ) ;
  double gm = std::pow( static_cast<double>(prod) ,
    1.0 / static_cast<double>(l) ) ;
  std::vector<double> reciprocals( l ) ;
  std::transform( numbers.begin( ) , numbers.end( ) ,
    reciprocals.begin( ) ,
    []( int n ) { return 1.0 / static_cast<double>( n ) ; } ) ;
  std::cout << std::accumulate( reciprocals.begin( ) , reciprocals.end( ) ,
    0.0 ) << std::endl ;
  double hm = static_cast<double>(l) / std::accumulate( reciprocals.begin() ,
    reciprocals.end( ) , 0.0 ) ;
  std::cout << "AM = " ;
  std::cout.setf( std::ios::fixed , std::ios::floatfield ) ;
  std::cout.precision( 1 ) ;
  std::cout << am << ", GM = " ;
  std::cout.precision( 1 ) ;
  std::cout << gm << ", HM = " ;
  std::cout.precision( 1 ) ;
  std::cout << hm << std::endl ;
  return 0 ;
}
