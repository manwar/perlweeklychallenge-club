#include <iostream>
#include <string>
#include <vector>
#include <map>
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

bool condition( const std::string & word , const std::map<char, int> &
      provided ) {
  std::map<char , int> lettercount ;
  for ( char c : word )
      lettercount[c]++ ;
  for ( char c : word ) {
      if ( ! ( provided.find( c ) != provided.end( ) &&
          (provided.find( c ))->second >=
          (lettercount.find( c ) )->second ) )
        return false ;
  }
  return true ;
}


int main( ) {
  std::cout << "Enter some words, separated by blanks!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> words ( split( line, " " ) ) ;
  std::cout << "Enter a word to take the characters from!\n" ;
  std::string comparator ;
  std::cin >> comparator ;
  std::map<char , int> compCount ;
  for ( char c : comparator )
      compCount[c]++ ;
  std::vector<std::string> selected ;
  for ( auto s : words ) {
      if ( condition( s , compCount ) ) {
    selected.push_back( s ) ;
      }
  }
  if ( selected.size( ) > 0 ) {
      std::vector<int> lengths  ;
      for ( auto s : selected )
    lengths.push_back( s.length( ) ) ;
      std::cout << std::accumulate( lengths.begin( ) , lengths.end( ) , 0 )
    << std::endl ;
  }
  else {
      std::cout << 0 << std::endl ;
  }
  return 0 ;
}
