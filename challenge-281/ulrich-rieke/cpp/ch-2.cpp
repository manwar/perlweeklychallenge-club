#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <sstream>
#include <cstdlib>
#include <algorithm>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::istringstream istr { text } ;
   std::string word ;
   std::vector<std::string> words ;
   while ( std::getline( istr , word , delimiter ) ) {
      words.push_back( word ) ;
   }
   return words ;
}

//create all fields of a chess board
std::vector<std::string> findAllFields( ) {
   std::string cols {"abcdefgh"} ;
   std::string rows {"12345678"} ;
   std::vector<std::string> board ;
   for ( int i = 0 ; i < cols.length( ) ; i++ ) {
      for ( int j = 0 ; j < rows.length( ) ; j++ ) {
	 std::string field { cols.substr( i , 1 ).append( rows.substr( j , 1 ) ) } ;
	 board.push_back( field ) ;
      }
   }
   return board ;
}

//all suitable fields on a chessboard are those that differ from the given field
// by an absolute difference of 2 in rows and of 1 in columns or vice versa
std::vector<std::string> findTargets( const std::string & field , const 
      std::vector<std::string> & board ) {
   std::vector<std::string> selected ;
   static const std::string columns {"abcdefgh"} ;
   static const std::string rows {"12345678"} ;
   auto selector = [field]( const auto & f ) {
      auto colfound = columns.find_first_of( field.substr( 0 , 1 ) ) ;
      auto rowfound = rows.find_first_of( field.substr( 1 , 1 ) ) ;
      auto fieldcol = columns.find_first_of( f.substr( 0 , 1 ) ) ;
      auto fieldrow = rows.find_first_of( f.substr( 1 , 1 ) ) ;
      auto coldiff = abs( colfound - fieldcol ) ;
      auto rowdiff = abs( rowfound - fieldrow ) ;
      return ( (coldiff == 1) && (rowdiff == 2)) || ( (coldiff == 2) &&
	    (rowdiff == 1 )) ;
   } ;
   std::copy_if( board.begin( ) , board.end( ) , std::back_inserter( selected ) , 
	 selector ) ;
   return selected ;
}

int main( ) {
   std::cout << "Enter a source and a target field!\n" ;
   std::string line ;
   std::getline( std::cin, line ) ;
   std::vector<std::string> fields { split( line , ' ' ) } ;
   std::vector<std::string> chessboard { findAllFields( ) } ;
   std::string sourceField { fields[ 0 ] } ;
   std::string targetField { fields[ 1 ] } ;
   std::vector<std::string> targets = findTargets( sourceField , chessboard ) ;
   int count = 1 ;
   while ( std::find( targets.begin( ) , targets.end( ) , targetField ) == 
	 targets.end( ) ) {
      count++ ;
      std::vector<std::string> newTargets , elementTargets  ;
      for ( auto it = targets.begin( ) ; it != targets.end( ) ; it++ ) {
	 elementTargets = findTargets( *it , chessboard ) ;
	 for ( auto f : elementTargets ) 
	    newTargets.push_back( f ) ;
	 elementTargets.clear( ) ;
      }
      for ( auto f : newTargets ) 
	 targets.push_back( f ) ;
   }
   std::cout << count << '\n' ;
   return 0 ;
}
