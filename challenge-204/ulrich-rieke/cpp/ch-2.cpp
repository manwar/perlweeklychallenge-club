#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

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

int main( ) {
  std::cout << "Enter some integers, separated by a blank!\n" ;
  std::cout << "Enter end to end!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> numberstrings ;
  std::vector<std::vector<std::string>> allNumberstrings ;
  std::vector<int> numbers ;
  while ( line != "end" ) {
      allNumberstrings.push_back( split ( line , " " ) ) ;
      std::getline( std::cin , line ) ;
  }
  std::cout << "Enter the number of rows:\n" ;
  int rows ;
  std::cin >> rows ;
  std::cout << "\nEnter the number of columns:\n" ;
  int columns ;
  std::cin >> columns ;
  for ( const auto & vec : allNumberstrings ) {
      for ( auto & s : vec )
    numbers.push_back( std::stoi( s ) ) ;
  }
  if ( numbers.size( ) % ( rows * columns ) == 0 ) {
      std::cout << '(' ;
      for ( int i = 0 ; i < rows ; i++ ) {
    std::cout << '(' ;
    for ( int j = i * columns ; j < i * columns + columns ; j++ ) {
        std::cout << *(numbers.begin( ) + j) << " " ;
    }
    std::cout << ") " ;
      }
      std::cout << ")\n" ;
  }
  else {
      std::cout << 0 << std::endl ;
  }
  return 0 ;
}
