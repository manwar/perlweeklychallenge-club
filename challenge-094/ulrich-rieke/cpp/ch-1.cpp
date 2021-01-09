#include <iostream>
#include <string>
#include <algorithm>
#include <vector>
#include <map>

int main( ) {
  std::cout << "Enter terms by line ( 0 to end ) )" ;
  std::string word ;
  std::vector<std::string> input ;
  std::getline( std::cin, word ) ;
  while ( word != "0" ) {
      input.push_back( word ) ;
      std::getline( std::cin, word ) ;
  }
  std::map<std::string, std::vector<std::string>> anagrams ;
  for ( std::string theWord : input ) {
      std::string original { theWord } ;
      std::sort( theWord.begin( ) , theWord.end( ) ) ;
      anagrams[ theWord ].push_back( original ) ;
  }
  std::cout << "[\n" ;
  for ( auto & p : anagrams ) {
      std::cout << " (" ;
      for ( auto w : p.second ) {
    std::cout << w << " " ;
      }
      std::cout << "),\n" ;
  }
  std::cout << "]" << std::endl ;
  return 0 ;
}
