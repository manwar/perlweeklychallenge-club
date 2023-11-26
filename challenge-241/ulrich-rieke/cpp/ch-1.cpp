#include <vector>
#include <iostream>
#include <string>
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
   std::cout << "Enter at least 3 positive integers in ascending order!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::cout << "Enter a positive integer!\n" ;
   int diff ;
   std::cin >> diff ;
   std::vector<std::string> numberstrings { split( line , " " ) } ;
   std::vector<int> numbers ;
   for ( auto s : numberstrings ) 
      numbers.push_back( std::stoi( s ) ) ;
   int result = 0 ;
   int len = numbers.size( ) ;
   for ( int i = 0 ; i < len - 2 ; i++ ) {
      for ( int j = i + 1 ; j < len - 1 ; j++ ) {
	 for ( int k = j + 1 ; k < len ; k++ ) {
	    if ( numbers[ j ] - numbers[ i ] == diff 
		  && numbers[ k ] - numbers[ j ] == diff ) 
	       result++ ;
	 }
      }
   }
   std::cout << result << std::endl ;
   return 0 ;
}

