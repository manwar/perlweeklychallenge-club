#include <iostream>
#include <map>
#include <vector>
#include <utility>
#include <algorithm>
#include <cstdlib>

bool isSpecial( int n ) {
  if ( n < 10 ) {
      return true ;
  }
  else {
      std::map<int, int> frequencies ;
      while ( n != 0 ) {
    frequencies[ n % 10]++ ;
    n /= 10 ;
      }
      std::vector<std::pair<int , int>> allPairs( frequencies.begin( ) ,
        frequencies.end( ) ) ;
      return std::all_of( allPairs.begin( ) , allPairs.end( ) , [] ( auto &
          p ) { return p.second == 1 ; } ) ;
  }
}

int main( int argc , char * argv[] ) {
  int num = std::atoi( argv[1] ) ;
  int count = 0 ;
  for ( int i = 1 ; i < num + 1 ; i++ ) {
      if ( isSpecial( i ) ) {
    count++ ;
      }
  }
  std::cout << count << std::endl ;
  return 0 ;
}
