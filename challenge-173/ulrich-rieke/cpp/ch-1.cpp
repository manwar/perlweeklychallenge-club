#include <iostream>
#include <vector>
#include <algorithm>
#include <cstdlib>

std::vector<int> takeApart( int n ) {
  std::vector<int> digits ;
  while ( n != 0 ) {
      digits.push_back( n % 10 ) ;
      n /= 10 ;
  }
  //the vector contains the digits in reverse order!
  //for the purposes of this task this doesn't matter!
  return digits ;
}

int main( int argc , char * argv[] ) {
  int number = std::atoi( argv[ 1 ] ) ;
  std::vector<int> digits( takeApart( number ) ) ;
  std::vector<int> differences ;
  for ( int i = 0 ; i < digits.size( ) - 1 ; i++ ) {
      differences.push_back( abs( digits[ i ] - digits[ i + 1 ] ) ) ;
  }
  if ( std::all_of( differences.begin( ) , differences.end( ) , []( int i ) {
        return i == 1 ; } ))
      std::cout << number << " is esthetic!\n" ;
  else
      std::cout << number << " is not esthetic!\n" ;
  return 0 ;
}
