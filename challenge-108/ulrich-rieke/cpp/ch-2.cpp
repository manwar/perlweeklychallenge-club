#include <vector>
#include <iostream>

int main( ) {
  std::vector<int> bellnumbers { 1 } ;
  std::vector<int> currentRow ;
  std::vector<int> previousRow { 1 } ;
  while ( bellnumbers.size( ) < 10 ) {
      currentRow.push_back( previousRow.back( )) ;
      int currentIndex = 0 ;
      while ( currentRow.size( ) < ( previousRow.size( ) + 1 ) ) {
    currentIndex++ ;
    currentRow.push_back( currentRow[ currentIndex - 1 ] +
          previousRow[ currentIndex - 1 ] ) ;
      }
      bellnumbers.push_back( *(currentRow.begin( ) ) ) ;
      previousRow = currentRow ;
      currentRow.clear( ) ;
  }
  std::cout << "These are the first 10 Bell numbers:\n" ;
  for ( int i = 1 ; i < 10 ; i++ ) {
      std::cout << " " << i << " : " << bellnumbers[ i - 1 ] << '\n' ;
  }
  std::cout << 10 << " : " << bellnumbers[9] << '\n' ;
  return 0 ;
}
