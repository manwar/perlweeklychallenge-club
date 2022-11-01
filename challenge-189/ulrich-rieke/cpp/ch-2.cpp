#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <utility>
#include <algorithm>
#include <numeric>

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

int findDegree( const std::vector<int> & numbers ) {
  std::map<int , int> frequencies ;
  for ( int i : numbers )
      frequencies[i]++ ;
  std::vector<std::pair<int , int>> allPairs ( frequencies.begin( ) , frequencies.end( )) ;
  return std::max_element( allPairs.begin( ) , allPairs.end( ) , []( auto & p1 , auto & p2 )
    { return p1.second < p2.second ; }  )->second ;
}

int main( ) {
  std::cout << "Enter a number of integers, separated by a blank!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> numberstrings = split( line , " " ) ;
  std::vector<int> numbers ;
  for ( auto & s : numberstrings ) {
      numbers.push_back( std::stoi( s ) ) ;
  }
  int degree = findDegree( numbers ) ;
  if ( degree == 1 )
      std::cout << *std::min_element( numbers.begin( ) , numbers.end( )) <<
    std::endl ;
  else {
      std::vector<std::vector<int>> subarrays ;
      int len = numbers.size( ) ;
      for ( int stepwidth = degree ; stepwidth < len + 1 ; stepwidth++ ) {
    for ( int start = 0 ; start < len - stepwidth + 1 ; start++ ) {
        std::vector<int> subarray ;
        for ( int pos = 0 ; pos < stepwidth ; pos++ ) {
          subarray.push_back( numbers[ start + pos ] ) ;
        }
        if ( findDegree( subarray ) == degree )
          subarrays.push_back( subarray ) ;
    }
      }
      std::vector<int> result = *std::min_element( subarrays.begin( ) , subarrays.end( ) ,
        []( const auto & la , const auto & lb ){ return std::accumulate( la.begin( ) ,
          la.end( ) , 0 ) < std::accumulate( lb.begin( ) , lb.end( ) , 0 ) ; } ) ;
      std::cout << "( " ;
      for ( int i : result )
    std::cout << i << " " ;
      std::cout << ')' << std::endl ;
  }
  return 0 ;
}
