#include <vector>
#include <utility>
#include <sstream>
#include <string>
#include <regex>
#include <iostream>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter the numbers of rows and columns separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   int rows = numbers[0] ;
   int cols = numbers[1] ;
   std::cout << "Enter some locations as comma-separated numbers in brackets!\n" ;
   std::getline( std::cin , line ) ;
   std::string for_number ("\\d" ) ;
   std::regex np { for_number } ;
   std::vector<int> locations ;
   auto end = std::sregex_token_iterator{} ;
   for ( auto it = std::sregex_token_iterator{ std::begin( line ) , 
	 std::end( line ) , np } ; it != end ; ++it ) {
      locations.push_back( std::stoi( *it ) ) ;
   }
   std::vector<std::pair<int , int>> coordinates ;
   int len = locations.size( ) ;
   for ( int i = 0 ; i < len - 1 ; i += 2 ) 
      coordinates.push_back( std::make_pair( locations[i] , locations[i + 1] ) ) ;
   std::vector<std::vector<int>> matrix ;
   for ( int i = 0 ; i < rows ; i++ ) {
      std::vector<int> matrixrow ;
      for ( int n = 0 ; n < cols ; n++ ) 
	 matrixrow.push_back( 0 ) ;
      matrix.push_back( matrixrow ) ;
   }
   for ( auto it = coordinates.begin( ) ; it != coordinates.end( ) ; ++it ) {
      for ( int c = 0 ; c < cols ; c++ ) {
	 matrix[it->first][c]++ ;
      }
      for ( int r = 0 ; r < rows ; r++ ) {
	 matrix[r][it->second]++ ;
      }
   }
   int sum = 0 ;
   for ( int r = 0 ; r < rows ; r++ ) {
      for ( int c = 0 ; c < cols ; c++ ) {
	 if ( matrix[r][c] % 2 == 1 ) 
	    sum++ ;
      }
   }
   std::cout << sum << '\n' ;
   return 0 ;
}
