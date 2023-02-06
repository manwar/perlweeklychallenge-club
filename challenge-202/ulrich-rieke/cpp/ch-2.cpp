#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <utility>
#include <iterator>

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

std::pair<int, int> findValley( const std::vector<int> & numbers , int pos ) {
  int currentpos = pos ;
  std::pair<int , int> result ;
  int len = numbers.size( ) ;
  do {
      currentpos++ ;
  } while ( currentpos < len && numbers[ currentpos ] <=
    numbers[ currentpos - 1 ] ) ;
  if ( currentpos == len ) {
      result = std::make_pair( pos , currentpos - 1 - pos) ;
  }
  else {
      do {
    currentpos++ ;
      } while ( currentpos < len && numbers[ currentpos ] >=
        numbers[ currentpos - 1 ] ) ;
      result = std::make_pair( pos , currentpos - 1 - pos ) ;
  }
  return result ;
}

bool myCompare( const std::pair<int , int> & myA , const std::pair<int , int>
      & myB ) {
  if ( myA.second == myB.second ) {
      return myA.first < myB.first ;
  }
  else {
      return myA.second > myB.second ;
  }
}

int main( ) {
  std::cout << "Enter some integers, separated by a blank!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> numberstrings ( split( line, " " ) ) ;
  std::vector<int> numbers ;
  for ( auto & s : numberstrings ) {
      numbers.push_back( std::stoi( s ) ) ;
  }
  int len = numbers.size( ) ;
  std::vector<std::pair<int , int>> positions ;
  for ( int i = 0 ; i < len - 1 ; i++ ) {
      std::pair<int , int> result { findValley( numbers , i ) } ;
      positions.push_back( result ) ;
  }
  std::sort( positions.begin( ) , positions.end( ) , myCompare ) ;
  int startpos = positions.begin( )->first ;
  int stride = positions.begin( )->second ;
  std::copy( numbers.begin( ) + startpos , numbers.begin( ) + startpos
    + stride + 1 , std::ostream_iterator<int>( std::cout , " , " ) );
  std::cout << std::endl ;
  return 0 ;
}
