#include <iostream>
#include <map>
#include <vector>

int findDigitSquare( int n ) {
  int sum = 0 ;
  while ( n != 0 ) {
      int remainder = n % 10 ;
      sum += ( remainder * remainder ) ;
      n /= 10 ;
  }
  return sum ;
}

bool isHappy( int n ) {
  std::map<int , int> frequencies ;
  int sum = findDigitSquare( n ) ;
  frequencies[ sum ]++ ;
  while ( sum != 1 && frequencies[sum] < 2 ) {
      sum = findDigitSquare( sum ) ;
      frequencies[ sum ]++ ;
  }
  return ( sum == 1 ) ;
}

int main( ) {
  std::vector<int> happies ;
  int current = 1 ;
  while ( happies.size( ) != 8 ) {
      if ( isHappy( current ) ) {
    happies.push_back( current ) ;
      }
      current++ ;
  }
  for ( int i : happies )
      std::cout << i << ' ' ;
  std::cout << std::endl ;
  return 0 ;
}
