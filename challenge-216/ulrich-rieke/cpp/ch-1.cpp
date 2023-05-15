#include <iostream>
#include <vector>
#include <string>
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

bool condition( const std::string & regi , const std::string & word ) {
  for ( std::string::size_type i = 0 ; i < regi.length( ) ; i++ ) {
      if ( word.find( regi.substr( i , 1 ) ) == std::string::npos ) {
    return false ;
      }
  }
  return true ;
}

int main( ) {
  std::cout << "Please enter some words, separated by blanks!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> words ( split( line , " " ) ) ;
  std::cout << "Enter , separated by blanks, 2 parts of a registration number!\n" ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> regiparts( split( line , " " ) ) ;
  std::string registration ( regiparts[ 0 ] + regiparts[ 1 ] ) ;
  std::string relevant_word ;
  for ( auto c : registration ) {
      if ( std::isalpha( c ) )
    relevant_word.push_back( static_cast<char>( tolower( c ) ) ) ;
  }
  std::vector<std::string> selected ;
  for ( auto word : words )
      if ( condition ( relevant_word , word ) )
    selected.push_back( word ) ;
  std::cout << "(" ;
  for ( auto word : selected ) {
      std::cout << word ;
      if ( word != selected.back( ) )
    std::cout << " , " ;
      else
    std::cout << ")\n" ;
  }
  return 0 ;
}
