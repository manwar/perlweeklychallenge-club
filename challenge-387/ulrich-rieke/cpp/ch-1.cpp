#include <iostream>
#include <string>
#include <vector>
using namespace std::string_literals ;

std::vector<int> findPositions( const std::string & current ) {
   std::vector<int> positions ;
   int len { static_cast<int>( current.length( ) ) } ;
   for ( int i = 0 ; i < len - 1; i++ ) {
      if ( current.substr( i , 2 ) == "01"s ) 
         positions.push_back( i ) ;
   }
   std::vector<int> result ;
   if ( positions.size( ) > 0 ) {
      result.push_back( positions[0] ) ;
      for ( int i = 1 ; i < positions.size( ) ; i++ ) {
         if ( positions[i] >= result.back( ) + 2 ) {
            result.push_back( positions[i] ) ;
         }
      }
   }
   return result ;
}

int main( ) {
   std::cout << "Enter a binary string!\n" ;
   std::string binary ;
   std::cin >> binary ;
   int len { static_cast<int>( binary.length( ) ) } ;
   int steps = 0 ;
   std::vector<int> foundpos { findPositions( binary ) } ;
   while ( foundpos.size( ) > 0 ) {
      for ( auto it = foundpos.begin( ) ; it != foundpos.end( ) ; ++it ) {
         binary.replace( *it , 2 , "10"s ) ;
      }
      steps++ ;
      foundpos = findPositions( binary ) ;
   }
   std::cout << steps << '\n' ;
   return 0 ;
}
