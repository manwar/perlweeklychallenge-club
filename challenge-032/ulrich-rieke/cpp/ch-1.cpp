#include <iostream>
#include <vector>
#include <map>
#include <algorithm>
#include <utility>
#include <fstream>

void printStrings( const std::vector<std::string> & strings ) {
  std::map<std::string, int> frequencies ;
  int maxlen = 0 ;
  for ( std::string str : strings ) {
      frequencies[ str ]++ ;
      if ( str.length( ) > maxlen )
    maxlen = str.length( ) ;
  }
  std::vector<std::pair<std::string , int>> orderedFreq { frequencies.begin( ),
      frequencies.end( ) } ;
  std::sort ( orderedFreq.begin( ) , orderedFreq.end( ) , []( const
        std::pair<std::string, int> a , const std::pair<std::string, int> b )
    { return a.second > b.second ; } ) ;
  std::string answer ;
  std::cout << "Output as csv : (y)es or (n)o ?\n" ;
  std::cin >> answer ;
  if ( answer.substr(0, 1 ) == "n" ) {
      for ( auto & p : orderedFreq ) {
    std::cout << p.first ;
    std::cout.width( maxlen - p.first.length( ) + 1 ) ;
    std::cout << p.second << std::endl ;
      }
  }
  else {
      for ( auto & p : orderedFreq ) {
    std::cout << p.first << ',' << p.second << '\n' ;
      }
  }
}

int main( int argc , char * argv[] ) {
  std::vector<std::string> argstrings ;
  std::vector<std::string> argfiles ;
  for ( int i = 1 ; i < argc ; i++ ) {
      std::string argument( argv[ i ] ) ;
      std::ifstream infile ( argument , std::ios::in ) ;
      if ( infile ) {
    argfiles.push_back( argument ) ;
    infile.close( ) ;
      }
      else {
    argstrings.push_back( argument ) ;
      }
  }
  if ( ! argstrings.empty( ) ) {
      std::cout << "Strings in the argument list:\n" ;
      printStrings( argstrings ) ;
  }
  if ( ! argfiles.empty( ) ) {
      for ( auto & file : argfiles ) {
        std::ifstream inputfile( file , std::ios::in ) ;
    std::vector<std::string> filelines ;
    std::string line ;
    std::cout << "Content of file " << file << " by frequency:\n" ;
    while ( inputfile ) {
        std::getline( inputfile , line ) ;
        filelines.push_back( line ) ;
    }
    inputfile.close( ) ;
    printStrings( filelines ) ;
      }
  }
  return 0 ;
}

