#include <algorithm>
#include <iostream>
#include <string>
#include <vector>

int levenshtein_dist( const std::string & a , const std::string & b ) {
  if ( a.length( ) == 0 )
      return b.length( ) ;
  if ( b.length( ) == 0 )
      return a.length( ) ;
  std::string tailA ( a.substr( 1 ) ) ;
  std::string tailB ( b.substr( 1 ) ) ;
  if ( a[0] == b[0] )
      return levenshtein_dist( tailA , tailB ) ;
  else {
      std::vector<int> lengths ;
      lengths.push_back( levenshtein_dist( tailA , b ) ) ;
      lengths.push_back( levenshtein_dist( a , tailB ) ) ;
      lengths.push_back( levenshtein_dist( tailA , tailB ) ) ;
      return 1 + *std::min_element( lengths.begin( ) , lengths.end( ) ) ;
  }
}

int main( int argc , char * argv[ ] ) {
  std::string A ( argv[ 1 ] ) ;
  std::string B ( argv[ 2 ] ) ;
  std::cout << "The edit distance of " << A << " and " << B << " is " ;
  std::cout << levenshtein_dist( A , B ) << std::endl ;
  return 0 ;
}
