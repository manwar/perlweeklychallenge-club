#include <iostream>
#include <map>
#include <string>
#include <algorithm>

int main( ) {
  std::cout << "Please enter a source string!\n" ;
  std::string source ;
  std::cin >> source ;
  std::cout << "Please enter a target string!\n" ;
  std::string target ;
  std::cin >> target ;
  std::map<char , int> sourceMap ;
  std::map<char, int> targetMap ;
  for ( char c : source )
      sourceMap[c]++ ;
  for ( char c : target )
      targetMap[c]++ ;
  if ( std::all_of( target.begin( ) , target.end( ) , [sourceMap, targetMap]
        ( char b ) { return sourceMap.find( b ) != sourceMap.end( )
          &&  sourceMap.find( b )->second >=
            targetMap.find( b )->second ; } ))
      std::cout << "true" ;
  else
      std::cout << "false" ;
  std::cout << std::endl ;
  return 0 ;
}
