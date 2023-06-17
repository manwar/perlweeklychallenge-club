#include <iostream>
#include <vector>
#include <string>
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

std::string to_binary_string( int n , int len) {
  std::string binstr ;
  int total = n ;
  while ( total != 0 ) {
      binstr.append( std::to_string( total % 2 ) ) ;
      total /= 2 ;
  }
  int difference = len - binstr.length( ) ;
  if ( difference > 0 ) {
      for ( int i = 0 ; i < difference ; i++ )
    binstr.append( std::string( "0" ) ) ;
  }
  std::reverse( binstr.begin( ) , binstr.end( ) ) ;
  return binstr ;
}

std::vector<int> extract( const std::vector<int> & numbers ,
      const std::string & binstring ) {
  std::vector<int> selection ;
  for ( int i = 0 ; i < binstring.length( ) ; i++ ) {
      if ( binstring.substr( i , 1 ) == "1" )
    selection.push_back( numbers[ i ] ) ;
  }
  return selection ;
}

bool is_arithmetic( const std::vector<int> & aSeq ) {
  int len = aSeq.size( ) ;
  int start = aSeq[1] - aSeq[0] ;
  for ( int i = 1 ; i < len - 1 ; i++ ) {
      if ( aSeq[ i + 1 ] - aSeq[ i ] != start ) {
    return false ;
      }
  }
  return true ;
}

int main ( ) {
  std::cout << "Enter some integers, separated by blanks!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> numberstrings ( split( line , " " ) ) ;
  std::vector<int> numbers ;
  for ( auto s : numberstrings )
      numbers.push_back( std::stoi( s ) ) ;
  int len = numbers.size( ) ;
  if ( is_arithmetic( numbers ) )
      std::cout << len << std::endl ;
  else {
      int maxlen = 0 ;
      int limit = static_cast<int>( std::pow( 2.0 ,
          static_cast<double>( len )) - 1 ) ;
      for ( int i = 0 ; i < limit + 1 ; i++ ) {
    std::string binstring ( to_binary_string( i , len ) ) ;
    if ( std::count( binstring.begin( ) , binstring.end( ) ,
          '1' ) > 1 ) {
        std::vector<int> selection ( extract( numbers , binstring ) ) ;
        if ( is_arithmetic( selection ) ) {
          int sublen = selection.size( ) ;
          if ( sublen > maxlen )
          maxlen = sublen ;
        }
    }
      }
      std::cout << maxlen << std::endl ;
  }
  return 0 ;
}
