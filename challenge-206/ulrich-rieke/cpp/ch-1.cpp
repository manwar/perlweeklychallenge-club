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

int findDifference( std::string & firstTime , std::string & secondTime ) {
  std::vector<std::string> firstTimeValues( split( firstTime , ":" ) ) ;
  std::vector<std::string> secondTimeValues( split( secondTime, ":" ) ) ;
  std::vector<int> firstTimeNums , secondTimeNums ;
  for ( auto s : firstTimeValues ) {
      firstTimeNums.push_back( std::stoi( s ) ) ;
  }
  for ( auto s : secondTimeValues ) {
      secondTimeNums.push_back( std::stoi( s ) ) ;
  }
  int secondTimePoint = *(secondTimeNums.begin( )) * 60 + *(secondTimeNums.begin( ) + 1 ) ;
  int firstTimePoint = *(firstTimeNums.begin( ) ) * 60 + *(firstTimeNums.begin( ) + 1 ) ;
  int diff = secondTimePoint - firstTimePoint ;
  if ( diff < 0 ) {
      secondTimePoint += 24 * 60 ;
      diff = secondTimePoint - firstTimePoint ;
  }
  return diff ;
}

int main( ) {
  std::cout << "Enter some times in the form <hours:minutes> , blanks to separate!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> times ( split ( line , " " ) ) ;
  int len = times.size( ) ;
  std::vector<int> differences ;
  std::sort( times.begin( ) , times.end( ) ) ;
  while ( std::next_permutation( times.begin( ) , times.end( ) )) {
      for ( int i = 0 ; i < len - 1 ; i++ ) {
    differences.push_back( findDifference( *(times.begin( ) + i ) ,
          *(times.begin( ) + i + 1 ))) ;
      }
  }
  std::cout << *std::min_element( differences.begin( ) , differences.end( ) ) <<
      std::endl ;
  return 0 ;
}
