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
   std::cout << "Enter 2 strings, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> words { split( line, " " ) } ;
   std::string merged ;
   int len1 = words[0].length( ) ;
   int len2 = words[1].length( ) ;
   if ( len1 != len2 ) {
      int smaller = std::min( len1 , len2 ) ;
      for ( int i = 0 ; i < smaller ; i++ ) {
	 merged += words[0].substr( i, 1 ) ;
	 merged += words[1].substr( i , 1 ) ;
      }
      if ( len1 > len2 ) {
	 for ( int i = smaller ; i < len1 ; i++ ) {
	    merged += words[0].substr( i , 1 ) ;
	 }
      }
      else {
	 for ( int i = smaller ; i < len2 ; i++ ) {
	    merged += words[1].substr( i , 1 ) ;
	 }
      }
   }
   else {
      for ( int i = 0 ; i < len1 ; i++ ) {
	 merged += words[0].substr( i , 1 ) ;
	 merged += words[1].substr( i , 1 ) ;
      }
   }
   std::cout << merged << '\n' ;
   return 0 ;
}
