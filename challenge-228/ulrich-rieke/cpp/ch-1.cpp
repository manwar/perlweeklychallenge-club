#include <iostream>
#include <vector>
#include <string>
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
   std::cout << "Enter some integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> numberstrings ( split( line , " " ) ) ;
   std::vector<int> numbers ;
   for ( auto s : numberstrings ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::vector<int> uniques ;
   for ( int i : numbers ) {
      if ( std::count( numbers.begin( ) , numbers.end( ) , i ) == 1 ) 
	 uniques.push_back( i ) ;
   }
   std::cout << std::accumulate( uniques.begin( ) , uniques.end( ) , 0 ) << std::endl ;
   return 0 ;
}
