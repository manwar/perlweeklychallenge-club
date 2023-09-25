#include <vector>
#include <iostream>
#include <string>

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
   std::cout << "Please enter some integers, separated by spaces!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> numberstrings( split( line, " " ) ) ;
   std::vector<int> numbers ;
   for ( auto s : numberstrings ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::vector<int> result ;
   for ( int n : numbers ) {
      if ( n != 0 ) 
	 result.push_back( n ) ;
      else {
	 result.push_back( 0 ) ;
	 result.push_back( 0 ) ;
      }
   }
   std::cout << "( " ;
   for ( int i = 0 ; i < numbers.size( ) ; i++ ) {
      std::cout << result[ i ] << " " ;
   }
   std::cout << " )\n" ;
   return 0 ;
}
