#include <string>
#include <fstream>
#include <iostream>
#include <set>
#include <vector>
#include <numeric>
#include <algorithm>

bool noLetterRepetitions( const std::string & s ) {
  std::set<char> letterSet( s.begin( ) , s.end( ) ) ;
  return letterSet.size( ) == s.length( ) ;
}

int main( ) {
  std::vector<std::string> shortChosenWords ;
  std::vector<std::string> longChosenWords ;
  std::string sourcefile {"dictionary.txt"} ;
  std::ifstream source( sourcefile ) ;
  if ( ! source )
      std::cerr << "Cannot find file " << sourcefile << " !\n" ;
  else {
      std::vector<std::string> collectedWords ;
      std::vector<std::string> wordsByStartLetter ;
      std::vector<std::string> alphabet( 26 ) ;
      std::iota( alphabet.begin( ) , alphabet.end( ) , 'a' ) ;
      while ( source ) {
    std::string line ;
    std::getline( source , line ) ;
    if ( noLetterRepetitions( line ) ) {
        collectedWords.push_back( line ) ;
    }
      }
      source.close( ) ;
      for ( const auto & start : alphabet ) {
    for ( const auto & w : collectedWords ) {
        if ( w.substr( 0 , 1 ) == start )
          wordsByStartLetter.push_back( w ) ;
    }
    std::sort( wordsByStartLetter.begin( ) , wordsByStartLetter.end( ),
          []( const auto & s1 , const auto & s2 ) { return s1.length( )
          < s2.length( ) ; } ) ;
    shortChosenWords.push_back( *wordsByStartLetter.begin( ) ) ;
    longChosenWords.push_back( wordsByStartLetter.back( ) ) ;
    wordsByStartLetter.clear( ) ;
      }
      std::cout << "one no-repetition-word per letter, short:\n" ;
      for ( const auto & s : shortChosenWords )
    std::cout << s << " " ;
      std::cout << std::endl ;
      std::cout << "one no-repetition word per letter, long:\n" ;
      for ( const auto & s : longChosenWords )
    std::cout << s << " " ;
      std::cout << std::endl ;
  }
  return 0 ;
}
