#include <string>
#include <vector>
#include <sstream>
#include <numeric>
#include <algorithm>
#include <iostream>

std::vector<int> toNumList( const std::string & text , char delim ) {
   std::istringstream istr { text } ;
   std::vector<std::string> tokens ;
   std::string word ;
   while ( std::getline( istr , word , delim ) ) {
      tokens.push_back( word ) ;
   }
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   return numbers ;
}

std::vector<std::vector<int>> findSquares( const std::vector<std::vector<
      int>> & matrix , const int row , const int col ) {
   int mini = std::min( static_cast<int>( matrix.size( )) - row , 
	    static_cast<int>(matrix[0].size( ) ) - col ) ;
   std::vector<std::vector<int>> allSquares ;
   for ( int i = 0 ; i < mini ; i++ ) {
      std::vector<int> small_square ;
      if ( i == 0 ) {
	 small_square.push_back( matrix[row][col] ) ;
	 allSquares.push_back( small_square ) ;
      }
      else {
	 for ( int r = row ; r < row + i + 1 ; r++ ) {
	    for ( int c = col ; c < col + i + 1 ; c++ ) {
	       small_square.push_back( matrix[r][c] ) ;
	    }
	 }
	 allSquares.push_back( small_square ) ;
      }
   }
   return allSquares ;
}

int findSquareSum( const std::vector<std::vector<int>> & matrix , 
      const int row , const int col ) {
   auto result { findSquares( matrix , row , col ) } ;
   std::vector<int> sizes ;
   for ( auto vec : result ) {
      if ( std::all_of( vec.begin( ) , vec.end( ) , [](const int i ) {
	       return i == 1 ; } ) ) {
	 sizes.push_back( static_cast<int>(vec.size( ) )) ;
      }
      else {
	 sizes.push_back( 0 ) ;
      }
   }
   if ( sizes.size( ) > 0 ) {
      return *std::max_element( sizes.begin( ) , sizes.end( ) ) ;
   }
   else {
      return 0 ;
   }
}

int main( ) {
   std::cout << "Enter some 0 and 1 separated by whitespace!\n" ;
   std::cout << "Enter <return> to end!\n" ;
   std::vector<std::vector<int>> matrix ;
   std::string line ;
   std::getline( std::cin , line ) ;
   while ( ! line.empty( ) ) {
      auto numberline { toNumList( line , ' ' ) } ;
      matrix.push_back( numberline ) ;
      std::getline( std::cin , line ) ;
   }
   int matrixlen = static_cast<int>( matrix.size( ) ) ;
   int rowlen = static_cast<int>( matrix[0].size( ) ) ;
   std::vector<int> squaresizes ;
   for ( int r = 0 ; r < matrixlen ; r++ ) {
      for ( int c = 0 ; c < rowlen ; c++ ) {
	 int sum = findSquareSum( matrix , r , c ) ;
	 squaresizes.push_back( sum ) ;
      }
   }
   if ( squaresizes.size( ) == 0 ) 
      std::cout << 0 << '\n' ;
   else 
      std::cout << *std::max_element( squaresizes.begin( ) , 
	    squaresizes.end( ) ) << '\n' ;
   return 0 ;
}



