#include <vector>
#include <algorithm>
#include <numeric>
#include <iostream>
#include <string>
#include <iterator>

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
  std::cout << "Enter some numbers greater than or equal to 0!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> numberstrings( split( line , " ")) ;
  std::vector<int> numbers ;
  for ( auto s : numberstrings )
      numbers.push_back( std::stoi( s ) ) ;
  if ( std::accumulate( numbers.begin( ) , numbers.end( ) , 0 ) %
    static_cast<int>( numbers.size( ) ) != 0 )
      std::cout << -1 << std::endl ;
  else {//all elements are equal
      int first_element = *numbers.begin( ) ;
      if ( std::all_of( numbers.begin( ) , numbers.end( ) , [first_element]
          ( const int i )  { return i == first_element ; } )) {
              std::cout << 0 << std::endl ;
      }
      else {//elements are not equal
    int count = 0 ;
    int start = *numbers.begin( ) ;
    while ( ! std::all_of( numbers.begin( ) , numbers.end( ) , [start]
          ( int i ) { return i == start ; })) {
        int maximum = *std::max_element( numbers.begin( ) , numbers.end( ) ) ;
        auto maxPos = std::find( numbers.begin( ) , numbers.end( ) , maximum ) ;
        int thePos = static_cast<int>( std::distance( numbers.begin( ),
            maxPos)) ;
        numbers[ thePos ]-- ;
        if ( thePos == 0 ) {
          numbers[ 1 ]++ ;
        }
        else {
          if ( thePos == static_cast<int>(numbers.size( ) - 1 )) {
          numbers[ numbers.size( ) - 2]++ ;
          }
          else {
          if ( numbers[ thePos - 1 ] < numbers[ thePos + 1]  ) {
            numbers[ thePos - 1 ]++ ;
          }
          else {
            if ( numbers[ thePos - 1 ] > numbers[ thePos + 1 ] ) {
            numbers[ thePos + 1 ]++ ;
            }
            else {//neighbouring elements are equal
            int minimum = *std::max_element( numbers.begin( ) ,
                  numbers.end( ), []( int a , int b)
                  { return a < b ;} ) ;
            auto minPos = std::find( numbers.begin( ) , numbers.end( ) ,
                  minimum ) ;
            if ( minPos > maxPos )
              numbers[ thePos + 1 ]++ ;
            else
              numbers[ thePos - 1 ]++ ;
            }
          }
          }
        }
        count++ ;
        start = *numbers.begin( ) ;
    }
    std::cout << count << std::endl ;
      }
  }
  return 0 ;
}
