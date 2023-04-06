#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <list>

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
  std::cout << "Please enter some integers, separated by a blank!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> numberstrings( split( line , " " ) ) ;
  std::vector<int> numbers ;
  for ( auto s : numberstrings )
      numbers.push_back( std::stoi( s ) ) ;
  std::sort( numbers.begin( ) , numbers.end( ) ) ;
  std::list<int> theNumbers ;
  for ( int i : numbers )
      theNumbers.push_back( i ) ;
  theNumbers.sort( ) ;
  theNumbers.unique( ) ;
  std::vector<int> allSums ;
  for ( auto it = theNumbers.begin( ) ; it != theNumbers.end( ) ; it++ ) {
      int sum = 0 ;
      int ct = std::count( numbers.begin( ) , numbers.end( ) , *it - 1) ;
      sum += ct * (*it - 1) ;
      ct = std::count( numbers.begin( ) , numbers.end( ) , *it ) ;
      sum += ct * *it ;
      ct = std::count( numbers.begin( ) , numbers.end( ) , *it + 1 ) ;
      sum += ct * (*it + 1 ) ;
      allSums.push_back( sum ) ;
  }
  std::cout<< *max_element( allSums.begin( ) , allSums.end( ) ) << std::endl ;
  return 0 ;
}
