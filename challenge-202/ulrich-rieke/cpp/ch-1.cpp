#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <cstdlib>

int main( int argc , char* argv[] ) {
  if ( argc < 4 ) {
      std::cout << "Enter a least 3 integers, separated by a blank!\n" ;
      return 1 ;
  }
  else {
      std::vector<int> numbers ;
      for ( int i = 1 ; i < argc ; i++ ) {
    numbers.push_back( std::atoi( argv[ i ] ) ) ;
      }
      int result = 0 ;
      int len = numbers.size( ) ;
      for ( int i = 0 ; i < len - 2 ; i++ ) {
    if ( std::all_of( numbers.begin( ) + i , numbers.begin( ) + i + 3 ,
          [ ]( int n ) { return n % 2 == 1 ; } ) )
        result = 1 ;
      }
      std::cout << result << std::endl ;
      return 0 ;
  }
}
------------------------------------------------------------------------------------
      task 1, in Haskell
------------------------------------------------------------------------------------

module Challenge202
  where
import Data.List.Split ( divvy )

solution :: [Int] -> Int
solution list = if any (\li -> all odd li ) $ divvy 3 1 list then 1 else 0
