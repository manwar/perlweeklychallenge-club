#include <vector>
#include <string>
#include <algorithm>
#include <cctype>
#include <iostream>

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
   std::cout << "Enter some words, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> allWords ( split( line, " " ) ) ;
   std::cout << "Enter a check string!\n" ;
   std::string checkstr ;
   std::getline( std::cin ,  checkstr ) ;
   std::string myCompare ;
   for ( auto s : allWords ) {
      std::transform( s.begin( ) , s.end( ) , s.begin( ) , tolower ) ;
      myCompare += s.substr( 0 , 1 ) ;
   }
   std::cout.setf( std::ios_base::boolalpha ) ;
   std::cout << ( checkstr == myCompare ) << std::endl ;
   return 0 ;
}

