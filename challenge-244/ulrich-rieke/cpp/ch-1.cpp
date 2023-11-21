#include <iostream>
#include <vector>
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
   std::cout << "Enter some integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> numberstrings { split( line , " " ) } ;
   std::vector<int> numbers ;
   for ( auto & s : numberstrings ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::vector<int> solution ;
   for ( int i = 0 ; i < numbers.size( ) ; i++ ) {
      int compare = numbers[ i ] ;
      int howmany = std::count_if( numbers.begin( ) , numbers.end( ) ,
	    [compare]( int n ) { return n < compare ; } ) ;
      solution.push_back( howmany ) ;
   }
   std::cout << "(" ;
   std::copy( solution.begin( ) , solution.end( ) ,
	 std::ostream_iterator<int>( std::cout , " " ) ) ;
   std::cout << ")\n" ;
   return 0 ;
}
