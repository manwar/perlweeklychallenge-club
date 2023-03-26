#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

int main( ) {
  std::cout << "Enter a binary string consisting of 1 and 0!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> subblocks ;
  int i = 0 ;
  int len = line.length( ) ;
  while ( i < len - 2 ) {
      subblocks.push_back( line.substr( i , 2 ) ) ;
      i += 2 ;
  }
  subblocks.push_back( line.substr( i , len - 1 )) ;
  if ( std::all_of( subblocks.begin( ) , subblocks.end( ) , []( auto s )
        { return s.find_first_of("23456789") == std::string::npos ; } )) {
    std::string last_element( subblocks.back( ) ) ;
    if ( last_element == "0" || last_element == "00" )
        std::cout << 1 << std::endl ;
    else
        std::cout << 0 << std::endl ;
  }
  else
      std::cout << 0 << std::endl ;
  return 0 ;
}
