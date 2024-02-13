#include <vector>
#include <iostream>
#include <set>
#include <string>
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
   std::vector<std::string> words { split( line , " " ) } ;
   std::set<std::string> ortho( words.begin( ) , words.end( ) ) ;
   std::set<std::string> reversed ;
   for ( auto w : words ) {
      std::string for_reverse { w } ;
      std::reverse( for_reverse.begin( ) , for_reverse.end( ) ) ;
      reversed.insert( for_reverse ) ;
   }
   std::set<std::string> common ;
   std::set_intersection( ortho.begin( ) , ortho.end( ) ,
	 reversed.begin( ) , reversed.end( ) , std::inserter( common , 
	    common.begin( ) ) ) ;
   std::cout << common.size( ) / 2 << '\n' ;
   return 0 ;
}

