#include <iostream>
#include <string>
#include <map>
#include <algorithm>
#include <vector>

int main( int argc , char * argv[] ) {
  if ( argc != 2 ) {
      std::cerr << "Please use <challenge194_2> <string>!\n" ;
      return 1 ;
  }
  else {
      std::string myString( argv[1] ) ;
      std::map<char , int> letterfrequencies ;
      for ( char c : myString ) {
    letterfrequencies[c]++ ;
      }
      std::vector<int> frequencies ;
      for ( auto p : letterfrequencies )
    frequencies.push_back( p.second ) ;
      int maximum = *std::max_element(frequencies.begin( ) ,
        frequencies.end( ) ) ;
      int minimum = *std::min_element( frequencies.begin( ) ,
        frequencies.end( ) ) ;
      int count = 0 ;
      for ( auto p : letterfrequencies ) {
    if ( p.second == minimum )
        count++ ;
      }
      if ( maximum == minimum + 1 && count == letterfrequencies.size( ) - 1 )
    std::cout << 1 << std::endl ;
      else
    std::cout << 0 << std::endl ;
      return 0 ;
  }
}
