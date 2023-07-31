#include <iostream>
#include <string>
#include <vector>
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

int mySubtr( int n , int min ) {
   n -= min ;
   if ( n < 0 ) 
      n = 0 ;
   return n ;
}

int main( ) {
   std::cout << "Enter some positive integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> numberstrings ( split ( line , " " ) ) ;
   std::vector<int> numbers ;
   for ( auto s : numberstrings ) {
      numbers.push_back( std::stoi( s ) ) ;
   }
   int rounds = 0 ;
   while ( ! std::all_of( numbers.begin( ) , numbers.end( ) , []( int n ) {
	    return n == 0 ; } ) ) {
      std::vector<int> positives ;
      std::copy_if( numbers.begin( ) , numbers.end( ) , std::back_inserter(
	       positives ) , []( int i ) { return i > 0 ; } ) ;
      int mini = *std::min_element( positives.begin( ) , positives.end( ) ) ;
      rounds++ ;
      std::transform( numbers.begin( ) , numbers.end( ) , numbers.begin( ) , 
	    [mini]( int i ) { return mySubtr( i , mini ) ; } ) ;
   }
   std::cout << rounds << std::endl ;
   return 0 ;
}
