#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>

std::vector<int> enterArray( ) {
  std::cout << "Enter different integers ( -1 to end ) !\n" ;
  int i ;
  std::vector<int> myIntegers ;
  std::cin >> i ;
  while ( i != -1 ) {
      myIntegers.push_back( i )  ;
      std::cin >> i ;
  }
  return myIntegers ;
}

int main( ) {
  std::vector<int> numbers = enterArray( ) ;
  int len = static_cast<int>( numbers.size( ) ) ;
  std::vector<double> averages ;
  double av = 0.0 ;
  int counted = 0 ;
  int sum = 0 ;
  for ( int num : numbers ) {
      sum += num ;
      counted++ ;
      av = static_cast<double>( sum ) / static_cast<double>( counted ) ;
      averages.push_back( av ) ;
  }
  for ( double n : averages )
      std::cout << n << " " ;
  std::cout << std::endl ;
  return 0 ;
}
