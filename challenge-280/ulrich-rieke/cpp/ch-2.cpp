#include <iostream>
#include <string>
#include <algorithm>

int main( ) {
   std::cout << "Enter a string with some vertical bars!\n" ;
   std::string line ;
   std::cin >> line ;
   if ( std::count( line.begin( ) , line.end( ) , '|' ) <= 1 ) {
      std::cout << std::count( line.begin( ) , line.end( ) , '*' ) << 
	 '\n' ;
   }
   else {
      bool barSeen = false ;
      std::string filtered ;
      for ( int i = 0 ; i < line.length( ) ; i++ ) {
	 char c = line[i] ;
	 if ( c != '|' ) 
	    filtered.append( 1, c ) ;
	 else {
	    if ( barSeen ) {
	       auto pos = filtered.find( '|' ) ;
	       filtered = filtered.substr( 0 , pos ) ;
	       barSeen = false ;
	    }
	    else {
	       filtered.append( 1 , '|' ) ;
	       barSeen = true ;
	    }
	 }
      }
      std::cout << std::count( filtered.begin( ) , filtered.end( ) , 
	    '*' ) << '\n' ;
   }
   return 0 ;
}
