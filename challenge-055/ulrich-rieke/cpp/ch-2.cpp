#include <iostream>
#include <vector>
#include <iterator>
#include <algorithm>
#include <utility>
#include <cstdlib>

//this function creates pairs of neighbouring numbers in a vector
std::vector<std::pair<int, int>> createDoublets ( const std::vector<int> & numbers ) {
  std::vector<std::pair<int , int>> doublets ;
  int len = numbers.size( ) ;
  for ( int i = 0 ; i < len - 1 ; i++ ) {
      std::pair<int , int> p { *(numbers.begin( ) + i ) ,
        *(numbers.begin( ) + i + 1 ) } ;
      doublets.push_back( p ) ;
  }
  return doublets ;
}

//in order to create a "wavy list of numbers", a vector of numbers is
//converted into a vector of pairs of neighbouring numbers. To be wavy,
//even-indexed pairs must be descending, odd-indexed ones must ascend.
//if this holds true for all pairs a permutation is "wavy"
bool myCondition( const std::vector<int> & numbers ) {
  std::vector<std::pair<int, int>> doublets { createDoublets( numbers ) } ;
  int len = doublets.size( ) ;
  std::vector<bool> validWavy ;
  for (int i = 0 ; i < len ; i++ ) {
      std::pair<int , int> p = doublets[ i ] ;
      validWavy.push_back (( i % 2 == 0 ) && ( p.first >= p.second ) ) ;
      validWavy.push_back (( i % 2 == 1 ) && ( p.first <= p.second ) ) ;
  }
  int i = 0 ;
  for ( auto b : validWavy ) {
      if ( b )
    i++ ;
  }
  return ( i == len ) ;
}

//numbers are entered as arguments on the command line. A minimum number
//of 2 is desirable and requested
int main( int argc, char * argv[] ) {
  std::vector<int> input ;
  if ( argc < 3 ) {
      std::cout << "There is little sense in permuting such short sequences!\n" ;
      return 1 ;
  }
  for ( int i = 1 ; i < argc ; i++ ) {
      input.push_back( std::atoi( argv[ i ] ) ) ;
  }
  std::vector<std::vector<int>> permus ;
  std::vector<std::vector<int>> wavies ;
  do {
      permus.push_back( input ) ;
  } while ( std::next_permutation( input.begin( ) , input.end( ) )) ;
  std::copy_if( permus.begin( ) , permus.end( ) ,
    std::back_inserter( wavies ) , myCondition ) ;
  for ( auto & it : wavies ) {
      std::cout << "[ " ;
      for ( int i : it ) {
    std::cout << i << " " ;
      }
      std::cout << " ]\n" ;
  }
  return 0 ;
}
