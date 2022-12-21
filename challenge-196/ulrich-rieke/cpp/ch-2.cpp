#include <iostream>
#include <vector>
#include <string>

std::vector<std::string> split( const std::string & startline , const std::string & sep ) {
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

int findEnd( const std::vector<int> & array , int pos ) {
  int current_index = pos ;
  current_index++ ;
  if ( current_index > array.size( ) - 1 ) {
      return pos ;
  }
  else {
      int current_number = array[ current_index ] ;
      while ( current_number - array[ current_index - 1 ] == 1 ) {
    current_index++ ;
    if ( current_index < array.size( ) )
        current_number = array[ current_index ] ;
    else
        break ;
      }
      current_index-- ;
      return current_index ;
  }
}

int main( ) {
  std::cout << "Please enter a sorted array of unique integers!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> numberstrings( split( line , " " ) ) ;
  std::vector<int> numbers ;
  for ( auto & s : numberstrings ) {
      numbers.push_back( std::stoi( s ) ) ;
  }
  std::vector<int> subarray ;
  std::vector<std::vector<int>> continuousRuns ;
  int pos = 0 ;
  while ( pos < numbers.size( ) ) {
      int end = findEnd( numbers , pos ) ;
      if ( end - pos > 0 ) {
    subarray.push_back( numbers[ pos ] ) ;
    subarray.push_back( numbers[ end ] ) ;
    continuousRuns.push_back( subarray ) ;
    subarray.clear( ) ;
      }
      pos = end + 1 ;
  }
  for ( const auto & suba : continuousRuns ) {
      std::cout << '[' << suba[0] << ',' << suba[1] << ']' ;
      std::cout << " ," ;
  }
  std::cout << std::endl ;
  return 0 ;
}
