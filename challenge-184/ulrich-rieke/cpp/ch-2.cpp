#include <iostream>
#include <string>
#include <vector>
#include <cctype>
#include <iterator>
#include <algorithm>

int main( ) {
  std::cout << "Please enter lines of letters and digits only, separated by blanks!\n" ;
  std::cout << "enter <return> to end!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> allInput ;
  while ( !line.empty( ) ) {
      allInput.push_back( line ) ;
      std::getline( std::cin , line ) ;
  }
  std::vector<std::vector<int>> allDigits ;
  std::vector<std::vector<char>> allLetters ;
  for ( const auto & s : allInput ) {
      std::vector<int> currentDigits ;
      std::vector<char> currentLetters ;
      for ( char c : s ) {
    if ( std::islower( c ) ) {
        currentLetters.push_back( c ) ;
    }
    if ( std::isdigit( c ) ) {
        currentDigits.push_back( c ) ;
    }
      }
      if ( currentDigits.size( ) > 0 ) {
    allDigits.push_back( currentDigits ) ;
      }
      if ( currentLetters.size( ) > 0 ) {
    allLetters.push_back( currentLetters ) ;
      }
  }
  std::cout << '[' ;
  for ( const auto & sequence : allDigits ) {
      std::cout << "[ " ;
      std::copy( sequence.begin( ) , sequence.end( ) , std::ostream_iterator<char>(
          std::cout , " " )) ;
      std::cout << "]," ;
  }
  std::cout << "] and [" ;
  for ( const auto & sequence : allLetters ) {
      std::cout << "[ " ;
      std::copy( sequence.begin( ) , sequence.end( ) , std::ostream_iterator<char>(
          std::cout , " " )) ;
      std::cout << "]," ;
  }
  std::cout << ']' << std::endl ;
  return 0 ;
}
