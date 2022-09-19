#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

std::vector<int> toDigits( int n ) {
  std::vector<int> digits ;
  while ( n != 0 ) {
      digits.push_back( n % 10 ) ;
      n /= 10 ;
  }
  return digits ;
}

bool isReversible( int n ) {
  std::string numberstring { std::to_string( n ) } ;
  std::reverse( numberstring.begin( ) , numberstring.end( ) ) ;
  int reversedNum { std::stoi( numberstring ) } ;
  int sum = n + reversedNum ;
  std::vector<int> sumDigits( toDigits( sum ) ) ;
  return std::none_of( sumDigits.begin( ) , sumDigits.end( ) , []( int i )
    { return i % 2 == 0 ; } ) ;
}

int main( ) {
  for ( int i = 1 ; i < 101 ; i++ ) {
      if ( isReversible( i ) ) {
    std::cout << i << ' ' ;
      }
  }
  std::cout << std::endl ;
  return 0 ;
}
