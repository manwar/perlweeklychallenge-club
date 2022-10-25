#include <iostream>
#include <string>
#include <vector>

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
  std::cout << "Please enter a number of integers, separated by a blank!\n" ;
  std::cout << "Enter a divisor as last positive integer!\n" ;
  std::string input ;
  std::getline( std::cin , input ) ;
  std::vector<std::string> inNumbers = split( input , " " ) ;
  std::vector<int> numbers ;
  for ( auto & s : inNumbers ) {
      numbers.push_back( stoi( s ) ) ;
  }
  int divisor = numbers.back( ) ;
  int len = numbers.size( ) ;
  int count = 0 ;
  for ( int i = 0 ; i < len - 2 ; i++ ) {
      for ( int j = i + 1 ; j < len - 1 ; j++ ) {
    if (( numbers[ i ] + numbers[ j ]) % divisor == 0 ) {
        count++ ;
    }
      }
  }
  std::cout << count << std::endl ;
  return 0 ;
}
