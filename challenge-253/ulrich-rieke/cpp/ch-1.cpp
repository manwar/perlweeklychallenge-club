#include <vector>
#include <string>
#include <iostream>
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
   std::cout << "Enter some strings, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> strings { split( line, " " ) } ;
   std::cout << "Enter a separator!\n" ;
   std::string separator ;
   std::getline( std::cin, separator ) ;
   std::vector<std::string> result ;
   for ( auto & s : strings ) {
      std::vector<std::string> parts { split( s , separator ) } ;
      for ( auto & part : parts ) {
	 if ( part.length( ) > 0 )
	    result.push_back( part ) ;
      }
   }
   std::cout << "( " ;
   std::copy( result.begin( ) , result.end( ) ,
	 std::ostream_iterator<std::string>(std::cout , " " ) ) ;
   std::cout << ")\n" ;
   return 0 ;
}
