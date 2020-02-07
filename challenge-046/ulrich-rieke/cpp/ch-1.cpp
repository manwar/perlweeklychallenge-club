#include <vector>
#include <algorithm>
#include <string>
#include <utility>
#include <map>
#include <iostream>

std::string decode ( const std::vector<std::string> & encoded ) {
  int len = encoded[0].length( ) ;
  std::string decoded ;
  for ( int i = 0 ; i < len ; i++ ) {
      std::map<std::string, int> frequencies ;
      for ( const std::string & word : encoded ) {
    frequencies[ word.substr( i , 1 ) ]++ ;
      }
      std::vector<std::pair<std::string , int> > howmany (
        frequencies.begin( ) , frequencies.end( ) ) ;
      decoded.append( std::max_element( howmany.begin( ) , howmany.end( ) ,
          []( auto & a, auto & b ) { return a.second < b.second ; } )->first) ;
  }
  return decoded ;
}

int main( ) {
  std::vector<std::string> theCodes { "Hxl4!" , "ce-lo" , "ze6lg" , "HWlvR" ,
      "q9m#o" } ;
  std::cout << decode( theCodes ) << std::endl ;
  return 0 ;
}
