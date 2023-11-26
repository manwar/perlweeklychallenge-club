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
      separated.push_back( startline.substr( start , pos - start ) ) ;
      start = pos + 1 ;
   } while ( pos != std::string::npos ) ;
   return separated ;
}

int main( ) {
   std::cout << "Please enter some integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> numberstrings { split ( line , " ") } ;
   std::vector<int> numbers ;
   for ( auto & s : numberstrings ) 
      numbers.push_back( std::stoi( s ) ) ;
   int sum = 0 ;
   int size = numbers.size( ) ;
   for ( int i = 0 ; i < size - 1 ; i++ ) {
      for ( int j = i + 1 ; j < size ; j++ ) {
	 if ( numbers[ i ] > 2 * numbers[ j ] ) 
	    sum++ ;
      }
   }
   std::cout << sum << std::endl ;
   return 0 ;
}
