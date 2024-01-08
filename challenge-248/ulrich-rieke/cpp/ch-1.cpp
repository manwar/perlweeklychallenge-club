#include <iostream>
#include <vector>
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
   std::cout << "Enter a string and a letter from this string, separated by blank!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> parts ( split( line, " " ) ) ;
   std::string searchstring { parts[0] } ;
   std::string letter { parts[1] } ;
   std::vector<int> letterpositions ;
   for ( int i = 0 ; i < searchstring.length( ) ; i++ ) {
      if ( searchstring.substr( i , 1 ) == letter ) 
	 letterpositions.push_back( i ) ;
   }
   for ( int n : letterpositions ) 
      std ::cout << n << " " ;
   std::cout << '\n' ;
   std::vector<int> result ;
   for ( int i = 0 ; i < searchstring.length( ) ; i++ ) {
      if ( searchstring.substr( i , 1 ) != letter ) {
	 std::vector<int> differences ;
	 for ( int p = 0 ; p < letterpositions.size( ) ; p++ ) 
	    differences.push_back( abs( letterpositions[p] - i ) ) ;
	 result.push_back( *std::min_element( differences.begin( ) , differences.end( ) )) ;
      }
      else {
	 result.push_back( 0 ) ;
      }
   }
   std::cout << "( " ;
   for ( int i : result ) {
      std::cout << i << " " ;
   }
   std::cout << " )\n" ;
   return 0 ;
}
