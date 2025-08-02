#include <iostream>
#include <string>
#include <vector>

using namespace std::string_literals ;

std::vector<std::string> createLine( const std::string & start ) {
   std::vector<std::string> line ;
   for ( int i = 0 ; i < 8 ; i++ ) {
      if ( i % 2 == 0 ) 
	 line.push_back( start ) ;
      else {
	 if ( start == "light"s ) 
	    line.push_back( "dark"s ) ;
	 else 
	    line.push_back( "light"s ) ;
      }
   }
   return line ;
}

int main( ) {
   std::cout << "Enter the coordinates of a field on a chess board!\n" ;
   std::string field ;
   std::cin >> field ;
   std::string cols {"abcdefgh"} ;
   std::string col { field.substr( 0 , 1 ) } ;
   int colpos = cols.find( col ) ;
   int row { std::stoi( field.substr( 1 , 1 ) ) } ;
   std::vector<std::string> baseline { createLine( "dark"s ) } ;
   bool result = false ;
   if ( row == 1 ) {
      result = (baseline[colpos] == "light"s) ;
      std::cout << std::boolalpha << result << '\n' ;
   }
   else {
      std::string foot { baseline[ colpos ] } ;
      std::vector<std::string> col_line { createLine( foot ) } ;
      result = (col_line[ row - 1 ] == "light"s) ;
      std::cout << std::boolalpha << result << '\n' ;
   }
   return 0 ;
}
