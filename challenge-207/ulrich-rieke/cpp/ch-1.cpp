#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <cctype>
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

bool myCondition( std::string word ) {
  static std::string row1 ( "qwertyuiop" ) ;
  static std::string row2 ( "asdfghjkl" ) ;
  static std::string row3 ( "zxcvbnm" ) ;
  std::transform( word.begin( ) , word.end( ) , word.begin( ) , tolower ) ;
  return std::all_of( word.begin( ), word.end( ) , []( char c ) {return row1.find(c) !=
    std::string::npos ; } ) || std::all_of( word.begin( ) , word.end( ) ,
        []( char c ){ return row2.find( c ) != std::string::npos ; } )
        || all_of( word.begin( ) , word.end( ) , []( char c ) { return
          row3.find( c ) != std::string::npos ; } ) ;
}

int main( ) {
  std::cout << "Please enter some words, separated by blanks!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> words ( split ( line , " " ) ) ;
  std::vector<std::string> output ;
  for ( auto & st : words ) {
      if ( myCondition( st ) )
    output.push_back( st ) ;
  }
  if ( output.size( ) > 0 ) {
      std::cout << "(" ;
      std::copy( output.begin( ) , output.end( ) , std::ostream_iterator<std::string>(
          std::cout , " " )) ;
      std::cout << ")\n" ;
  }
  else {
      std::cout << "()\n" ;
  }
  return 0 ;
}
