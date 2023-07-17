#include <vector>
#include <iostream>
#include <string>
#include <algorithm>

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
  std::cout << "Enter some sentences, enter fin to end!\n" ;
  std::vector<std::string> sentences ;
  std::string line ;
  std::getline( std::cin , line  ) ;
  while ( line != "fin" ) {
      if (line.substr(0 , 1 ) == " " || line.back( ) == ' ' ) {
    std::cout << "There should be no spaces at the beginning and the end!\n" ;
    std::cout << "Re-enter!\n" ;
      }
      else {
    sentences.push_back( line ) ;
      }
      std::getline( std::cin , line ) ;
  }
  std::vector<int> lengths ;
  for ( auto s : sentences ) {
      std::vector<std::string> words ( split( s , " " ) ) ;
      lengths.push_back( words.size( ) ) ;
  }
  std::cout << *std::max_element( lengths.begin( ) , lengths.end( ) ) <<
      std::endl ;
  return 0 ;
}
