#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <ranges>

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
   std::cout << "Enter some integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> numberstrings( split( line , " " )) ;
   std::vector<int> numbers ;
   for ( auto s : numberstrings ) 
      numbers.push_back( std::stoi( s ) ) ;
   int maxi = *std::max_element( numbers.begin( ) , numbers.end( ) ) ;
   int mini = *std::min_element( numbers.begin( ) , numbers.end( ) ) ;
   std::vector<int> result ;
   for ( int i : numbers | std::views::filter( [maxi,mini]( int n ) { return n 
	    != maxi && n != mini ; } ) ) 
      result.push_back( i ) ;
   if ( result.size( ) == 0 ) 
      std::cout << -1 << std::endl ;
   else {
      std::cout << "(" ;
      for ( int i : result ) {
	 std::cout << i ;
	 if ( i != result.back( ) ) {
	    std::cout << "," ;
	 }
	 else {
	    std::cout << ")" ;
	 }
      }
      std::cout << std::endl ;
   }
   return 0 ;
}
