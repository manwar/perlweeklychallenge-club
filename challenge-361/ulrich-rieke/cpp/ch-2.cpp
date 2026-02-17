#include <iostream>
#include <vector>
#include <algorithm>
#include <string>
#include <sstream>
#include <iterator>

std::vector<std::string> split( const std::string & text , const char
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) )
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter a row of 0 or 1 , <enter> to end!\n" ;
   std::string line ;
   std::vector<std::vector<int>> matrix ;
   std::getline( std::cin , line ) ;
   while ( line.length( ) > 0 ) {
      auto tokens { split( line , ' ' ) } ;
      std::vector<int> row ;
      for ( auto s : tokens ) 
         row.push_back( std::stoi( s ) ) ;
      matrix.push_back( row ) ;
      std::getline( std::cin , line ) ;
   }
   int selected = std::count_if( matrix.begin( ) , matrix.end( ) , []( const
            auto r) { return std::all_of( r.begin( ) , r.end( ) , []( int d) {
               return d == 0 ; } ) ; } ) ;
   int result = 0 ;
   if ( selected != 1 ) {
      result = -1 ;
   }
   else {
      auto pos = std::find_if( matrix.begin( ) , matrix.end( ), []( const 
               auto row) { return std::all_of( row.begin( ) , row.end( ) , 
                  []( const int i) { return i == 0 ; } ) ;}) ;
      int relpos = static_cast<int>( std::distance( matrix.begin( ) , pos ) ) ;
      for ( int i = 0 ; i < matrix.size( ) ; i++ ) {
         if ( (i != relpos) && matrix[i][relpos] != 1 ) {
            result = -1 ;
            break ;
         }
         result = relpos ;
      }
   }
   std::cout << result << '\n' ;
   return 0 ;
}
