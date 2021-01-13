#include <string>
#include <map>
#include <algorithm>
#include <iostream>

int main( int argc , char * argv[] ) {
  std::string s( argv[ 1 ] ) ;
  std::map<char, int> frequencies ;
  int len = s.length( ) ;
  std::string fnr ;
  for ( int i = 0 ; i < len ; i++ ) {
      frequencies[ s[i] ]++ ;
      if ( frequencies[ s[i] ] == 1 )
    fnr.push_back( s.at( i ) ) ;
      if ( frequencies[ s[i] ] > 1 ) {
    int singleletters = std::count_if( frequencies.begin( ) ,
          frequencies.end( ) , []( auto & p ) { return p.second == 1 ; }) ;
    if ( singleletters == 1 ) {
        auto iter = std::find_if( frequencies.begin( ) , frequencies.end( ) ,
          []( const auto & p ) { return p.second == 1 ; } ) ;
        fnr.push_back( iter->first ) ;
    }
    if ( singleletters == 0 ) {
        fnr.push_back( '#' ) ;
    }
    if ( singleletters > 1 ) {
        int fnrlength = fnr.length( ) ;
        int i = fnrlength - 1 ;
        while ( frequencies[ fnr[ i ] ] != 1 ) {
          i-- ;
        }
        fnr.push_back( fnr[ i ] ) ;
    }
      }
  }
  std::cout << fnr << '\n' ;
  return 0 ;
}
