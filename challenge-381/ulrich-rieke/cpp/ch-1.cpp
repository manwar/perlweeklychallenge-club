#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <set>
#include <numeric>

std::vector<std::string> split( const std::string &text , const char
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter an n x n matrix of numbers 1 to n!\n" ;
   std::string line ;
   std::vector<std::string> matrixlines ;
   std::getline( std::cin , line ) ;
   while ( line.length( ) > 0 ) {
      matrixlines.push_back( line ) ;
      std::getline( std::cin , line ) ;
   }
   std::vector<std::vector<int>> matrix ;
   for ( auto row : matrixlines ) {
      std::vector<int> numberrow ;
      auto rowtokens { split( row , ' ' ) } ;
      for ( auto w : rowtokens ) {
         numberrow.push_back( std::stoi( w ) ) ;
      }
      matrix.push_back( numberrow ) ;
   }
   int len = static_cast<int>( matrix.size( ) ) ;
   std::vector<int> startnumbers( len ) ;
   std::iota( startnumbers.begin( ) , startnumbers.end( ) , 1 ) ;
   std::set<int> comparison { startnumbers.begin( ) , startnumbers.end( ) } ;
   bool row_ok  ;
   for ( int i = 0 ; i < len ; i++ ) {
      std::set<int> rowset { matrix[i].begin( ) , matrix[i].end( ) } ;
      if ( rowset != comparison ) {
         row_ok = false ;
         break ;
      }
      row_ok = true ;
   }
   bool col_ok ;
   for ( int col = 0 ; col < len ; col++ ) {
      std::set<int> colset ;
      for ( int row = 0 ; row < len ; row++ ) {
         colset.insert( matrix[row][col] ) ;
      }
      if ( colset != comparison ) {
         col_ok = false ;
         break ;
      }
      col_ok = true ;
   }
   std::cout << std::boolalpha << ( col_ok && row_ok ) << '\n' ;
   return 0 ;
}



