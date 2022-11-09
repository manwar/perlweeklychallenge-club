#include <iostream>
#include <string>
#include <cctype>
#include <algorithm>

int main( ) {
  std::cout << "Please enter a word!\n" ;
  std::string line ;
  std::cin >> line ;
  if ( (std::isupper( static_cast<int>( line[0] )) &&
    std::all_of( line.begin( ) + 1 , line.end( ) , []( char c )
      {return std::islower( static_cast<int>( c )) ; } )) ||
    std::all_of( line.begin( ) , line.end( ) , []( char c )
        { return std::isupper( static_cast<int>( c )) ; }) ||
    std::all_of( line.begin( ) , line.end( ) , []( char c )
        { return std::islower( static_cast<int>( c )) ; }) )
    std::cout << 1 ;
  else
      std::cout << 0 ;
  std::cout << std::endl ;
  return 0 ;
}
