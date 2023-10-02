#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <set>
#include <iterator>
#include <cctype>

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
  std::cout << "Enter some words, separated by blanks!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> entered ( split( line , " " ) ) ;
  int len = entered.size( ) ;
  std::vector<std::string> allLower ;
  for ( auto s : entered ) {
      std::transform( s.begin( ) , s.end( ) , s.begin( ) , tolower ) ;
      allLower.push_back( s ) ;
  }
  std::set<char> old_intersection ;
  for ( char c : allLower[ 0 ] )
      old_intersection.insert( c ) ;
  if ( len == 1 ) {
  }
  else {
      std::set<char> new_intersection ;
      for ( int i = 1 ; i < len ; i++ ) {
    std::set<char> wordSet ;
    for ( char c : allLower[ i ] )
        wordSet.insert( c ) ;
    std::set_intersection( old_intersection.begin( ) ,
          old_intersection.end( ) , wordSet.begin( ) , wordSet.end( ) ,
          std::inserter( new_intersection , new_intersection.begin( ) ) ) ;
    old_intersection = new_intersection ;
      }
      std::cout << "( " ;
      std::copy( old_intersection.begin( ) , old_intersection.end( ) ,
        std::ostream_iterator<char>( std::cout , " " )) ;
      std::cout << ")" << std::endl ;
  }
  return 0 ;
}
