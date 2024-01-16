#include <vector>
#include <iostream>
#include <algorithm>
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
   std::cout << "Enter some integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> numberstrings( split( line , " " ) ) ;
   std::vector<int> numbers ;
   for ( auto s : numberstrings )
      numbers.push_back( std::stoi( s ) ) ;
   std::vector<int> selected ;
   for ( int i = 0 ; i < numbers.size( ) ; i++ ) {
      if ( i % 10 == numbers[ i ] )
	 selected.push_back( i ) ;
   }
   if ( selected.size( ) > 0 ) 
      std::cout << *std::min_element( selected.begin( ) , selected.end( ) ) ;
   else {
      std::cout << -1 ;
   }
   std::cout << std::endl ;
   return 0 ;
}
