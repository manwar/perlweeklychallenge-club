#include <iostream>
#include <vector>
#include <string>
#include <limits>
#include <numeric>
#include <algorithm>

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

int main( ) {
   std::cout << "Enter some 0 and 1 , separated by blanks!\n" ;
   std::cout << "Enter <return> to end!\n" ;
   std::vector<std::vector<int>> matrix ;
   std::string line ;
   std::getline( std::cin , line ) ;
   while ( line.length( ) > 0 ) {
      std::vector<std::string> numberline { split( line , " " ) } ;
      std::vector<int> numbers ;
      for ( auto s : numberline ) 
	 numbers.push_back( std::stoi( s ) ) ;
      matrix.push_back( numbers ) ;
      std::getline( std::cin , line ) ;
   }
   int validRows = std::count_if( matrix.begin( ) , matrix.end( ) , [](
	    auto row ) {return std::accumulate( row.begin( ) , row.end( ),
	       0 ) == 1 ; } ) ;
   int validCols = 0 ;
   for ( int col = 0 ; col < matrix[0].size( ) ; col++ ) {
      std::vector<int> transposed ;
      for ( int row = 0 ; row < matrix.size( ) ; row++ ) {
	 transposed.push_back( matrix[row][col] ) ;
      }
      if ( std::accumulate( transposed.begin( ) , transposed.end( ) , 0 )
	    == 1 ) 
	 validCols++ ;
   }
   std::cout << std::min( validRows , validCols ) << '\n' ;
   return 0 ;
}
	 



