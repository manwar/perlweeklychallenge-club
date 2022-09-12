#include <iostream>
#include <string>
#include <vector>
#include <string>
#include <algorithm>
#include <fstream>
#include <map>

int main( ) {
  std::string infile ( "temperature.txt" ) ;
  std::vector<std::string> dates ;
  std::map<std::string , int> temperatures ;
  std::ifstream instream( infile ) ;
  std::string line ;
  if ( ! instream ) {
      std::cerr << "Couldn't find " << infile << " !\n" ;
      std::exit( 1 ) ;
  }
  while ( instream.good( ) ) {
      std::getline( instream , line ) ;
      if ( line.length( ) > 0 ) {
    std::string part = line.substr( 0 , 10 )  ;
    dates.push_back( part ) ;
    int temp = std::stoi(line.substr( 12 )) ;
    temperatures[ part ] = temp ;
      }
  }
  instream.close( ) ;
  std::sort( dates.begin( ) , dates.end( ), []( const auto & stra ,
    const auto & strb ) { return stra.compare( strb ) == -1 ; } ) ;
  for ( int i = 1 ; i < dates.size( ) ; i++ ) {
    auto firstIt = temperatures.find( dates[ i ] ) ;
    auto secondIt = temperatures.find( dates[ i - 1 ] ) ;
    if ( firstIt->second > secondIt->second )
      std::cout << firstIt->first << std::endl ;
  }
  return 0 ;
}
