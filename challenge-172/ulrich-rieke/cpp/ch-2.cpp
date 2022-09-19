#include <vector>
#include <iostream>
#include <algorithm>
#include <string>

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

double findMedian( const std::vector<int> & numbers ) {
  int size = numbers.size( ) ;
  if ( size % 2 == 0 ) {
      return static_cast<double>( numbers[size / 2  - 1] + numbers[size / 2] ) / 2 ;
  }
  else
      return static_cast<double>( numbers[ size / 2 ] ) ;
}

int main( ) {
  std::cout << "Please enter an array of integers, blank to separate!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> numbers { split( line , " " ) } ;
  while ( numbers.size( ) < 5 ) {
      std::cout << "At least 5 numbers should be entered!\n" ;
      std::getline( std::cin , line ) ;
      numbers = split( line , " " ) ;
  }
  std::vector<int> nums ( numbers.size( ) ) ;
  int size = numbers.size( ) ;
  std::transform( numbers.begin( ) , numbers.end( ) , nums.begin( ) ,
    []( auto & s ) { return std::stoi( s ) ; } ) ;
  std::sort( nums.begin( ) , nums.end( ) ) ;
  std::cout << std::endl ;
  std::cout << "Minimum : " << nums[0] << std::endl ;
  std::cout << "Median : " << findMedian( nums ) << std::endl ;
  std::vector<int> firstHalf ;
  std::vector<int> secondHalf ;
  if ( size % 2 == 0 ) {
      for ( auto it = nums.begin( ) ; it != nums.begin( ) + size / 2  ; ++it )
    firstHalf.push_back( *it ) ;
      for ( auto it = nums.begin( ) + size / 2 ; it != nums.end( ) ; ++it )
    secondHalf.push_back( *it ) ;
  }
  else {
      for ( auto it = nums.begin( ) ; it != nums.begin( ) + size / 2 + 1 ; ++it )
    firstHalf.push_back( *it ) ;
      for ( auto it = nums.begin( ) + size / 2 + 1 ; it != nums.end( ) ; ++it )
    secondHalf.push_back( *it ) ;
  }
  std::cout << "First quartile : " << findMedian( firstHalf ) << std::endl ;
  std::cout << "Third quartile : " << findMedian( secondHalf ) << std::endl ;
  std::cout << "Maximum : " << nums.back( ) << std::endl ;
  return 0 ;
}
