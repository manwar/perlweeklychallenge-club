#include <iostream>
#include <cstdlib>
#include <string>
#include <regex>

int main( int argc , char * argv[ ] ) {
  int n = std::atoi( argv[ 1 ] ) ;
  std::string condition( R"(1)" ) ;
  std::regex cond( condition ) ;
  int total = 0 ;
  for ( int i = 1 ; i < n + 1 ; i++ ) {
      if ( ! regex_search( std::to_string( i ) , cond ) )
    total++ ;
  }
  std::cout << total << std::endl ;
  return 0 ;
}
