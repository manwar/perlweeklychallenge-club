#include <iostream>
#include <string>
#include <algorithm>
#include <vector>
#include <utility>
#include <iterator>
#include <map>

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

std::map<std::string, int> toIndexPairs(
      const std::vector<std::string> & words ) {
  std::map<std::string, int> values ;
  int i = 0 ;
  for ( auto s : words ) {
    values[s] = i ;
    i++ ;
  }
  return values ;
}

int main( ) {
  std::cout << "Enter some unique strings, separated by blanks!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> firstWords ( split( line , " " ) ) ;
  std::cout << "Enter some more unique strings, separated by blanks!\n" ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> secondWords ( split( line , " " ) ) ;
  std::map<std::string, int> firstMap( toIndexPairs( firstWords ) ) ;
  std::map<std::string , int> secondMap( toIndexPairs( secondWords ) ) ;
  std::vector<std::string> commonWords ;
  std::sort( firstWords.begin( ) , firstWords.end( ) ) ;
  std::sort( secondWords.begin( ) , secondWords.end( ) ) ;
  std::vector<std::string> result ;
  std::set_intersection( firstWords.begin( ) , firstWords.end( ) ,
    secondWords.begin( ) , secondWords.end( ) ,
    std::back_inserter( result ) ) ;
  if ( result.size( ) > 0 ) {
      std::vector<std::pair<std::string , int>> allIndices ;
      for ( auto it = result.begin( ) ; it != result.end( ) ; it++ ) {
    allIndices.push_back( std::make_pair( *it , firstMap[*it] +
          secondMap[*it] )) ;
      }
      std::sort( allIndices.begin( ) , allIndices.end( ) , []( const auto  p1 ,
          const auto p2 ){ return p1.second < p2.second ; } ) ;
      int minimum = allIndices.begin( )->second ;
      std::vector<std::string> output ;
      for ( auto & p : allIndices ) {
    if ( p.second == minimum )
        output.push_back( p.first ) ;
      }
      std::sort( output.begin( ) , output.end( ) ) ;
      std::cout << "(" ;
      std::copy( output.begin( ) , output.end( ) ,
        std::ostream_iterator<std::string>( std::cout , " " )) ;
      std::cout << ")\n" ;
  }
  else
      std::cout << "()" << std::endl ;
  return 0 ;
}
