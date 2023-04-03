#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <numeric>

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

bool isValid( const std::vector<int> & numbers ) {
  int len = numbers.size( ) ;
  if ( len == 0 || len == 1 )
      return true ;
  else {
      if ( len == 2 ) {
    return ( ! ( (numbers[ 0 ] > 0 ) && ( numbers[ 1 ] < 0 ) ) ) ;
      }
      else {
    std::vector<int> indices ( numbers.size( ) - 2 ) ;
    std::iota( indices.begin( ) , indices.end( ) , 0 ) ;
    return std::none_of( indices.begin( ) , indices.end( ) , [numbers]( int i ) {
          return (numbers[i] > 0 && numbers[ i + 1 ] < 0 ) ; } ) ;
      }
  }
}

std::vector<int> eliminate( const std::vector<int> & numbers ) {
  std::vector<int> afterElimination ;
  int len = numbers.size( ) ;
  int pos = 0 ;
  while ( ! ( numbers[ pos ] > 0 && numbers[ pos + 1 ] < 0 ) ) {
      afterElimination.push_back( numbers[ pos ] ) ;
      pos++ ;
  }
  int diff = abs( numbers[ pos ] ) - abs( numbers[ pos + 1 ] ) ;
  if ( diff > 0 )
      afterElimination.push_back( numbers[ pos ] ) ;
  if ( diff == 0 ) {
  }
  if ( diff < 0 ) {
      afterElimination.push_back( numbers[ pos + 1 ] ) ;
  }
  pos += 2 ;
  if ( pos < len ) {
      while ( pos < len ) {
    afterElimination.push_back( numbers[ pos ] ) ;
    pos++ ;
      }
  }
  return afterElimination ;
}

int main( ) {
  std::cout << "Enter some positive and negative integers, separated by blanks!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> numberstrings( split( line, " " ) ) ;
  std::vector<int> numbers ;
  for ( auto s : numberstrings )
      numbers.push_back( std::stoi( s ) ) ;
  std::vector<int> afterEliminate = eliminate( numbers ) ;
  while ( ! isValid( afterEliminate ) ) {
      afterEliminate = eliminate( afterEliminate ) ;
  }
  if ( afterEliminate.size( ) > 0 ) {
      std::cout << '(' ;
      for ( int i : afterEliminate )
    std::cout << i << " " ;
      std::cout << ")\n" ;
  }
  else
      std::cout << "()\n" ;
  return 0 ;
}
