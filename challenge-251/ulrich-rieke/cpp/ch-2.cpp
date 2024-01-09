#include <iostream>
#include <vector>
#include <set>
#include <string>
#include <algorithm>
#include <iterator>

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
   std::cout << "Please enter m lines of n integers, separated by blanks!\n" ;
   std::cout << "Enter <return> to end!\n" ;
   std::vector<std::vector<int>> matrix ;
   int lucky = -1 ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::vector<int>> columns  ;
   while ( line.length( ) > 0 ) {
      std::vector<int> numberline ;
      std::vector<std::string> numberstrings( split ( line, " " ) ) ;
      for ( auto s : numberstrings ) 
	 numberline.push_back( std::stoi( s ) ) ;
      matrix.push_back( numberline ) ;
      std::getline( std::cin , line ) ;
   }
   int colnumber = matrix[0].size( ) ;
   for ( int c = 0 ; c < colnumber ; c++ ) {
      std::vector<int> column ;
      for ( int r = 0 ; r < matrix.size( ) ; r++ ) {
	 column.push_back( matrix[r][c] ) ;
      }
      columns.push_back( column ) ;
   }
   std::set<int> rowminima ;
   for ( auto it = matrix.begin( ) ; it != matrix.end( ) ; ++it ) {
      rowminima.insert( *std::min_element( it->begin( ) , it->end( ) ) ) ;
   }
   std::set<int> colmaxima ;
   for ( auto it = columns.begin( ) ; it != columns.end( ) ; ++it ) {
      colmaxima.insert( *std::max_element( it->begin( ) , it->end( ) ) ) ;
   }
   std::vector<int> intersect ; 
   std::set_intersection( rowminima.begin( ) ,
	 rowminima.end( ) , colmaxima.begin( ) , colmaxima.end( ) , 
	 std::inserter( intersect , intersect.begin( ) )) ;
   if ( intersect.size( ) > 0 ) 
      lucky = *intersect.begin( ) ;
   std::cout << lucky << '\n' ;
   return 0 ;
}
