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

int main( ) {
   std::cout << "Enter some words , separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> words ( split( line , " " ) ) ;
   std::cout << "Enter a prefix!\n" ;
   std::string prefix ;
   std::cin >> prefix ;
   std::cout << static_cast<int>( std::count_if( words.begin( ) , 
	    words.end( ) , [prefix]( auto & s ) { return s.substr( 0 , 
	       prefix.length( ) ) == prefix ; } )) << std::endl ;
   return 0 ;
}
