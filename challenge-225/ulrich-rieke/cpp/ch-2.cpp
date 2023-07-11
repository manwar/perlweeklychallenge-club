#include <iostream>
#include <string>
#include <vector>

std::vector<std::string> split( const std::string & startline ,
      const std::string & sep ) {
  std::vector<std::string> separated ;
  std::string::size_type start { 0 } ;
  std::string::size_type pos ;
  do {
      pos = startline.find_first_of( sep , start ) ;
      separated.push_back( startline.substr(start , pos - start )) ;
      start = pos + 1 ;
  } while ( pos != std::string::npos ) ;
  return separated ;
}

std::vector<int> find_left_array( const std::vector<int> & numbers ) {
  int len = numbers.size( ) ;
  int limit = len / 2 ;
  std::vector<int> left_array ;
  left_array.push_back( 0 ) ;
  int left_sum = 0 ;
  for ( int i = 0 ; i < limit + 1 ; i++ ) {
      left_sum += numbers[ i ] ;
      left_array.push_back( left_sum ) ;
  }
  return left_array ;
}

std::vector<int> find_right_array( const std::vector<int> & numbers ) {
  int len = numbers.size( ) ;
  int left_limit = 0 ;
  if ( len % 2 == 1 )
      left_limit = len / 2 ;
  else
      left_limit = len / 2 - 1 ;
  std::vector<int> right_array ;
  int right_sum = 0 ;
  for ( int i = left_limit ; i < len ; i++ )
      right_sum += numbers[ i ] ;
  right_array.push_back( right_sum ) ;
  for ( int i = left_limit ; i < len ; i++ ) {
      right_sum -= numbers[ i ] ;
      right_array.push_back( right_sum ) ;
  }
  right_array.push_back( 0 ) ;
  return right_array ;
}

int main( ) {
  std::cout << "Enter some integers, separated by blanks!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> numberstrings( split( line , " " ) ) ;
  std::vector<int> numbers ;
  for ( auto s : numberstrings )
      numbers.push_back( std::stoi( s ) ) ;
  if (numbers.size( ) == 1)
      std::cout << "(0)\n" ;
  else {
      std::vector<int> result ;
      std::vector<int> left_array( find_left_array( numbers )) ;
      std::vector<int> right_array( find_right_array( numbers )) ;
      for ( int i = 0 ; i < left_array.size( ) ; i++ ) {
    result.push_back( std::abs( left_array[ i ] - right_array[ i ] )) ;
      }
      std::cout << "(" ;
      for ( int i : result ) {
    std::cout << i ;
    if ( i != result.back( ) )
        std::cout << "," ;
    else
        std::cout << ")\n" ;
      }
  }
  return 0 ;
}
