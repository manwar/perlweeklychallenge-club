#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <cmath>

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

bool condition( const std::vector<int> & subarray ) {
  for ( int i = 0 ; i < subarray.size( ) - 1 ; i++ ) {
      int sum = subarray[ i ] + subarray[ i + 1 ] ;
      double root = std::sqrt( static_cast<double>(sum) ) ;
      int rootint = static_cast<int>(std::floor( root ) ) ;
      if ( rootint * rootint != sum ) {
    return false ;
      }
  }
  return true ;
}

int main( ) {
  std::cout << "Please enter some integers, separated by blanks!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> numberstrings ( split( line , " " ) ) ;
  std::vector<int> numbers ;
  for ( auto s : numberstrings ) {
      numbers.push_back( std::stoi( s ) ) ;
  }
  std::sort( numbers.begin( ) , numbers.end( ) ) ;
  std::vector<std::vector<int>> solution ;
  if ( condition( numbers ) ) {
      solution.push_back( numbers ) ;
  }
  while ( std::next_permutation( numbers.begin( ) , numbers.end( ) ) ) {
      if ( condition ( numbers ) ) {
    solution.push_back( numbers ) ;
      }
  }
  std::cout << "(" ;
  if ( solution.size( ) == 0 ) {
      std::cout << "())\n" ;
  }
  else {
      for ( auto seq : solution ) {
    std::cout << "(" ;
    for ( int i : seq ) {
        std::cout << i << " ";
    }
    std::cout << ")" ;
    if ( seq != solution.back( ) ) {
        std::cout << "," ;
    }
      }
      std::cout << ")\n" ;
  }
  return 0 ;
}
