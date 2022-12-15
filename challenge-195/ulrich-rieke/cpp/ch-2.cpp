#include <iostream>
#include <string>
#include <map>
#include <utility>
#include <algorithm>
#include <vector>

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

int main( ) {
  std::cout << "Please enter some integers, separated by blanks!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<int> evens ;
  std::vector<std::string> numberstrings( split( line , " " ) ) ;
  for ( auto & s : numberstrings ) {
      int num = std::stoi( s ) ;
      if ( num % 2 == 0 )
    evens.push_back( num ) ;
  }
  if ( evens.size( ) != 0 ) {
      std::map<int , int> frequencies ;
      for ( int i : evens ) {
    frequencies[ i ]++ ;
      }
      std::vector<std::pair<int , int>> allFrequencies ( frequencies.begin( ),
        frequencies.end( ) ) ;
      std::sort ( allFrequencies.begin( ) , allFrequencies.end( ) ,
        [ ] ( const auto & a, const auto & b ) { return a.second
        > b.second ; } ) ;
      if ( allFrequencies.begin( )->second !=
        (allFrequencies.begin( ) + 1)->second ) {
    std::cout << allFrequencies.begin( )->first << std::endl ;
      }
      else {
    std::sort( evens.begin( ) , evens.end( ) ) ;
    std::cout << *evens.begin( ) << std::endl ;
      }
  }
  else {
      std::cout << -1 << std::endl ;
  }
  return 0 ;
}
