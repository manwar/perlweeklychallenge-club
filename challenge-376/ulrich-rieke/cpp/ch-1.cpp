#include <iostream>
#include <string>
#include <sstream>
#include <vector>

std::vector<std::string> split( const std::string & text , const char
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr ,  word , delimiter) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

std::vector<std::string> make_chessboard( ) {
   std::vector<std::string> chessboard ;
   std::string row ;
   for ( int i = 1 ; i < 9 ; i++ ) {
      if ( i % 2 == 1 ) {
         for ( int j = 0 ; j < 4 ; j++ ) {
            row.append( std::string( "BW" ) ) ;
         }
      }
      else {
         for ( int j = 0 ; j < 4 ; j++ ) {
            row.append( std::string( "WB" ) ) ;
         }
      }
      chessboard.push_back( row ) ;
      row.clear( ) ;
   }
   return chessboard ;
}

int main( ) {
   std::cout << "Enter two chessfields separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto fields { split( line , ' ' ) } ;
   std::string columns {"abcdefgh"} ;
   auto chessboard { make_chessboard( ) } ;
   std::cout << std::boolalpha << ( chessboard[std::stoi(fields[0].
            substr( 1 , 1)) - 1].substr( columns.find(
                  fields[0].substr( 0 , 1 )), 1) == 
         chessboard[std::stoi( fields[1].substr( 1 , 1 )) - 1].substr(
            columns.find( fields[1].substr( 0 , 1 )), 1)) << '\n' ;
   return 0 ;
}
