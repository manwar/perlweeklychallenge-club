#include <iostream>
#include <vector>
#include <algorithm>
#include <string>
#include <numeric>

std::vector<std::string> split( const std::string & startline ,
      const std::string & sep ) {
   std::vector<std::string> separated ;
   std::string::size_type start { 0 } ;
   std::string::size_type pos ;
   do {
      pos = startline.find_first_of( sep , start ) ;
      separated.push_back( startline.substr(start , pos - start )) ;
      start = pos + 1 ;
   } while ( pos != std::string::npos ) ;
   return separated ;
}

std::vector<int> enter_row( ) {
   std::cout << "Enter some integers, separated by blanks!\n" ;
   std::vector<int> numbers ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> numberstrings { split( line , " " ) } ;
   for ( auto str : numberstrings ) 
      numbers.push_back( std::stoi( str ) ) ;
   return numbers ;
}

bool is_diagonal( const std::vector<std::vector<int>> & matrix ) {
   int len = matrix.size( ) ;
   std::vector<int> positions( len ) ;
   std::iota( positions.begin( ) , positions.end( ) , 0 ) ;
   return std::all_of( positions.begin( ) , positions.end( ) ,
	 [&matrix]( int i ) { return matrix[i][i] != 0 ; } ) ;
}

bool is_antidiagonal( const std::vector<std::vector<int>> & matrix ) {
   int len = matrix.size( ) ;
   std::vector<int> positions( len ) ;
   std::iota( positions.begin( ) , positions.end( ) , 0  ) ;
   return std::all_of( positions.begin( ) , positions.end( ) , [&matrix,len]( int i ) 
	 { return matrix[i][len - 1 - i] != 0 ; } ) ;
}

bool rest_zero( const std::vector<std::vector<int>> & matrix ) {
   int len = matrix.size( ) ;
   for ( int row = 0 ; row < len ; row++ ) {
      for ( int col = 0 ; col < len ; col++ ) {
	 if (  row != col && row + col != len - 1 && matrix[row][col] != 0 ) 
	    return false ;
      }
   }
   return true ;
}

int main( ) {
   std::vector<std::vector<int>> matrix ;
   std::vector<int> row { enter_row( ) } ;
   int len = row.size( ) ;
   matrix.push_back( row ) ;
   for ( int i = 0 ; i < len - 1 ; i++ ) {
      row = enter_row( ) ;
      matrix.push_back( row ) ;
   }
   if ( is_diagonal( matrix ) && is_antidiagonal( matrix ) && rest_zero( matrix ) )
      std::cout << "true\n" ;
   else 
      std::cout << "false\n" ;
   return 0 ;
}
