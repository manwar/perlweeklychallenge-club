#include <string>
#include <vector>
#include <utility>
#include <iostream>

std::string flip( const std::string & doorstate ) {
  if ( doorstate == "open" ) {
      return "closed" ;
  }
  else {
      return "open" ;
  }
}

int main( ) {
  std::vector<std::pair<std::string, int> > theDoors ;
      for ( int i = 1 ; i < 501 ; i++ ) {
    theDoors.push_back( std::make_pair( "open" , i ) ) ;
      }
  for ( int i = 2 ; i < 501 ; i++ ) {
      if ( i < 251 ) {
    for ( int j = i ; j < 501 ; j += i ) {
        const std::string state {theDoors[ j - 1].first } ;
        std::string newState { flip ( state ) } ;
        theDoors[ j - 1 ] = std::make_pair( newState , theDoors[ j - 1 ].second ) ;
    }
      }
      else {
    theDoors[ i - 1 ] = std::make_pair( flip( theDoors[ i - 1 ].first ) ,
          theDoors[ i - 1 ].second ) ;
      }
  }
  for ( auto & p : theDoors ) {
      if ( p.first == "open" ) {
    std::cout << "Door " << p.second << " is open!\n" ;
      }
  }
  return 0 ;
}
