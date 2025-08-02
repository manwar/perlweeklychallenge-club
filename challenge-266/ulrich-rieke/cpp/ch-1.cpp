#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <utility>
#include <ranges>
#include <algorithm>

namespace rng = std::ranges ;

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
   std::vector<std::string> firstWords { split( line, " " ) } ;
   std::cout << "Enter some more words, separated by blanks!\n" ;
   line.clear( ) ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> secondWords { split( line, " " ) } ;
   std::map<std::string, int> frequencies ;
   for ( auto it = firstWords.begin( ) ; it != firstWords.end( ) ; it++ ) 
      frequencies[*it]++ ;
   for ( auto it = secondWords.begin( ) ; it != secondWords.end( ) ; it++ )
      frequencies[*it]++ ;
   std::vector<std::pair<std::string, int>> allWords { frequencies.begin( ) , 
      frequencies.end( ) } ;
   std::vector<std::string> selected ;
   if ( allWords.size( ) > 0 ) {
      std::cout << "( " ;
      for ( auto p : allWords | rng::views::filter([]( auto pa ){ return pa.second == 
	       1 ; } )) {
	    selected.push_back( p.first ) ;
      }
      for ( auto w : selected ) 
	 std::cout << w << ' ' ;
      std::cout << ")\n" ;
   }
   else {
      std::cout << "()\n" ;
   }
   return 0 ;
}


