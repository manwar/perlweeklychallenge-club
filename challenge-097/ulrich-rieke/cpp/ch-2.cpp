#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <cstdlib>
#include <algorithm>
#include <numeric>

bool isInputValid( const std::string & input , int n ) {
  return input.length( ) % n == 0 ;
}

//how many digits must be changed to make them all equal
int countToMakeAllEqual( const std::string & input ) {
  std::map<std::string , int> frequencies ;
  frequencies["0"] = 0 ;
  frequencies["1"] = 0 ;
  int len = input.length( ) ;
  for ( int i = 0 ; i < len ; i++ ) {
      frequencies[ input.substr( i , 1 )]++ ;
  }
  if ( frequencies[ "0" ] == len || frequencies[ "1" ] == len )
      return 0 ;
  int bigger = std::max( frequencies["0"] , frequencies[ "1" ] ) ;
  return len - bigger ;
}

int main( int argc, char * argv[ ] ) {
  if ( argc != 3 ) {
      std::cerr << "There should be 2 arguments, call <challenge097_2> <string> <number>!" ;
      return 1 ;
  }
  std::string input( argv[ 1 ] ) ;
  int blocks { std::atoi( argv[ 2 ] ) } ;
  if ( ! isInputValid( input , blocks ) ) {
      std::cerr << "the number of digits in the binary string should be a multiple of " ;
      std::cerr << blocks << " !" << std::endl ;
      return 2 ;
  }
  int len = input.length( ) ;
  int chunknumber = len / blocks ;
  int chunklength { len / chunknumber } ;
  std::vector<std::string> words ;
  //for all blocks to be equal we transpose the blocks, that is the first letters
  //of every block form a word, the second letters and so on
  //we then see how many digits have to be flipped to make all digits equal
  std::string transposed ;
  for ( int i = 0 ; i < chunklength ; i++ ) {
      for ( int j = 0 ; j < chunknumber ; j++ ) {
    transposed.append( input.substr( i + j * chunklength , 1 ) ) ;
    if ( transposed.length( ) == chunknumber ) {
        words.push_back( transposed ) ;
        transposed.clear( ) ;
    }
      }
  }
  std::vector<int> alterations ;
  for ( std::string & word : words ) {
      alterations.push_back( countToMakeAllEqual( word ) ) ;
  }
  std::cout << std::accumulate( alterations.begin( ) , alterations.end( ) , 0 )
      << std::endl ;
  return 0 ;
}
