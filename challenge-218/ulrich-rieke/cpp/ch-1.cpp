#include <iostream>
#include <string>
#include <vector>
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

int main( ) {
  std::cout << "Enter at least 3 integers, separated by blanks!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> numberstrings( split( line , " " )) ;
  std::vector<int> numbers ;
  for ( auto s : numberstrings )
      numbers.push_back( std::stoi( s ) ) ;
  if ( numbers.size( ) == 3 ) {
      std::cout << std::accumulate( numbers.begin( ) , numbers.end( ) , 1 ,
        std::multiplies<int>( ) ) << '\n' ;
  }
  else {
      int len = numbers.size( ) ;
      std::vector<int> products ;
      for ( int i = 0 ; i < len - 2 ; i++ ) {
    for ( int j = i + 1 ; j < len - 1 ; j++ ) {
        for ( int k = j + 1 ; k < len ; k++ ) {
          products.push_back( numbers[ i ] * numbers[ j ] * numbers[ k ] ) ;
        }
    }
      }
      std::cout << *max_element( products.begin( ) , products.end( ) ) << '\n' ;
  }
  return 0 ;
}
