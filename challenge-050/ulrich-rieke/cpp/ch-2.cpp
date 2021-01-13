#include <vector>
#include <set>
#include <iostream>
#include <algorithm>
#include <cstdlib>
#include <ctime>

std::vector<int> findNobles( std::vector<int> & randoms ) {
  std::vector<int> nobles ;
  int len = randoms.size( ) ;
  std::sort( randoms.begin( ) , randoms.end( ) ) ;
  for ( int i = 0 ; i < len ; i++ ) {
      if ( randoms[ i ] == len - 1 - i )
    nobles.push_back( randoms[ i ] ) ;
  }
  return nobles ;
}

int myGenerator( ) {
  return 1 + std::rand( ) / ((RAND_MAX + 1u ) / 50 ) ;
}

int main( ) {
  std::srand( std::time( nullptr ) ) ;
  int howmany = myGenerator() ;
  std::vector<int> randomNumbers( howmany ) ;
  std::generate_n( randomNumbers.begin( ) , howmany, myGenerator ) ;
  std::set<int> numbersUnique ;
  for ( int i : randomNumbers ) {
      numbersUnique.insert( i ) ;
  }
  std::vector<int> theNumbers( numbersUnique.begin( ) , numbersUnique.end( ) ) ;
  std::vector<int> myNobles { findNobles( theNumbers ) } ;
  if ( myNobles.empty( ) )
      std::cout << "There are no nobles this time!\n" ;
  else {
      for ( int i : myNobles ) {
    std::cout << i << " " ;
      }
      std::cout << '\n' ;
  }
  return 0
;
}
