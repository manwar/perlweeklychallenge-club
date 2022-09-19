#include <string>
#include <map>
#include <algorithm>
#include <iostream>
#include <vector>

int main( ) {
  std::cout << "Please enter a string!\n" ;
  std::string input ;
  getline( std::cin , input ) ;
  std::map<std::string , int> frequencies ;
  int len = input.length( ) ;
  for ( int i = 0 ; i < len ; i++ ) {
      frequencies[ input.substr( i , 1 )]++ ;
  }
  std::vector<int> findPositions ;
  for ( const auto & p : frequencies ) {
      if ( p.second == 1 ) {
    findPositions.push_back( static_cast<int>( input.find( p.first ))) ;
      }
  }
  std::cout << *std::min_element( findPositions.begin( ) , findPositions.end( ) ) <<
      std::endl ;
  return 0 ;
}
