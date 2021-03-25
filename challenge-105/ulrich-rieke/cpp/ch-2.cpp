#include <iostream>
#include <string>
#include <vector>
#include <regex>
#include <cstring>

int main( int argc, char* argv[] ) {
  std::string name { argv[ 1 ] } ;
  std::string affixed ;
  std::vector<std::string> components {"bo-b" , "Bonana-fanna fo-f" , "Fee fi mo-m" } ;
  std::regex vowels {"[AEIOU]"} ;
  std::regex consonants { "[BFM]" } ;
  std::string firstLetter { name.substr( 0 , 1 ) } ;
  if ( std::regex_match( firstLetter , vowels )) {
      affixed = name ;
      for ( auto & c : affixed )
    c = std::tolower( c ) ;
  }
  else {
      if ( std::regex_match( firstLetter, consonants ) ) {
    char compareLetter { static_cast<char>(std::tolower ( name[ 0 ] )) } ;
    for ( auto & s: components ) {
        if ( s.back( ) == compareLetter ) {
          s = s.substr( 0 , s.length( ) - 1 ) ;
        }
    }
      }
      affixed = name.substr( 1 ) ;
  }
  std::cout << name << ", " << name << ' ' << *(components.begin( )) <<
      affixed << '\n' ;
  for ( int i = 1 ; i < 3 ; i++ ) {
      std::cout << *(components.begin( ) + i ) << affixed << '\n' ;
  }
  std::cout << name << "!\n" ;
  return 0 ;
}
