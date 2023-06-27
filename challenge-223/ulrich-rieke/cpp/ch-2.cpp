#include <iostream>
#include <vector>
#include <string>
#include <list>
#include <algorithm>
#include <iterator>
#include <numeric>

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

std::list<int>::iterator findPos( std::list<int> & numbers ) {
  int len = numbers.size( ) ;
  std::list<int>::iterator pos =  numbers.begin( )  ;
  if ( len == 0 || len == 1 ) {
      pos = numbers.begin( ) ;
  }
  if ( len > 1 ) {
      int minimum = *std::min_element( numbers.begin( ) , numbers.end( ) ) ;
      int howmany = std::count( numbers.begin( ) , numbers.end( ) ,
        minimum ) ;
      if ( len == 2 ) {
    auto it = numbers.begin( ) ;
    auto the_first = it ;
    auto the_second = it ;
    int a = *the_first ;
    ++the_second ;
    int b = *the_second ;
    if ( a > b )
        pos = the_second ;
    else
        pos = the_first ;
      }
      if ( len == 3 ) {
    pos++ ;
      }
      if ( len > 3 ) {
    pos = numbers.begin( ) ;
    int max_product = 0 ;
        //search the list for the minimum
    //if the minimum is found , see whether it is found at the beginning
    //or the end of the list or in between and multiply appropriately
    //unfortunately, a list is a little bit unwieldy to traverse
    for ( auto it = numbers.begin( ) ; it != numbers.end( ) ; ++it ) {
        if (*it == minimum ) {
          auto factor = it ;
          if ( it == numbers.begin( ) ) {
          ++factor ;
          }
          if ( *it == numbers.back( ) ) {
          --factor ;
          }
          if ( it == numbers.begin( ) || *it == numbers.back( ) ) {
          int product = *it * *factor ;
          if ( product > max_product ) {
            max_product = product ;
            pos = it ;
          }
          }
          else { //it is neither at the beginning nor the end of list
          auto end = it ;
          --factor ;
          ++end ;
          int product = *factor * *it * *end ;
          if ( product > max_product ) {
            max_product = product ;
            pos = it ;
          }
          }
        }
    }
      }
  }
  return pos ;
}

int main( ) {
  std::cout << "Enter some integers, separated by blanks!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> numberstrings( split( line , " " ) ) ;
  std::list<int> numbers ;
  for ( auto s : numberstrings ) {
      numbers.push_back( std::stoi( s ) ) ;
  }
  int len = numbers.size( ) ;
  if ( len == 1 ) {
      std::cout << *numbers.begin( ) << std::endl ;
  }
  else {
      int sum = 0 ;
      while ( len > 1 ) {
      auto pos = findPos( numbers ) ;
      if ( pos == numbers.begin( ) ) {
        auto end = pos ;
        ++end ;
        sum += *numbers.begin( ) * *end ;
      }
      if ( *pos == numbers.back( ) ) {
        auto start = pos ;
        --start ;
        sum += *start * *pos ;
      }
      if ( pos != numbers.begin( ) && *pos != numbers.back( ) ) {
        auto start = pos ;
        auto end = pos ;
        --start ;
        ++end ;
        sum += *start * *pos * *end ;
      }
      numbers.erase( pos ) ;
      len = numbers.size( ) ;
      }
      sum += *numbers.begin( ) ;
      std::cout << sum << std::endl ;
  }
  return 0 ;
}
