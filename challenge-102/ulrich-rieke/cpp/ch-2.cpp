#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <cstdlib>

int main( int argc, char * argv[] ) {
  bool firsttime = true ; //the first time we enter num to the string
  int num = std::atoi( argv[ 1 ] ) ;
  std::string hashstring ; //holds the final output
  int sum = 0 ;
  std::vector<std::string> elements ;//we add numbers and hashes elementw.
  if ( num == 1 ) {
      hashstring = "#" ;
      std::cout << hashstring << std::endl ;
      return 0 ;
  }
  else {
      elements.push_back( std::string( "#" ) ) ;
      sum += 1 ;
      while ( sum < num ) {
    if ( elements.back( ) == "#" ) {//we add a number now
        int newnumber = 0 ;
        if ( firsttime ) {
          newnumber = num ;//we add the length of the string as number
          firsttime = false ;
        }
        else {
          std::string sofar  ;
          for ( auto s : elements ) {
          sofar.append( s ) ;
          }
          newnumber = num - sofar.length( ) + 1 ;
          std::string numstring( std::to_string( newnumber ) ) ;
          elements.push_back( numstring ) ;
          sum += numstring.length( ) ;
        }
    }
    else {//number as last element, so we add another hash
        elements.push_back( std::string( "#" ) ) ;
        sum += 1 ;
    }
      }
      std::reverse( elements.begin( ) , elements.end( ) ) ;
      for ( auto s : elements ) {
    hashstring.append( s ) ;
      }
      std::cout << hashstring << std::endl ;
      return 0 ;
  }
}
