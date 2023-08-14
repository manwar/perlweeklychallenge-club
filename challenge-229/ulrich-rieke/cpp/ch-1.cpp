#include <vector>
#include <string>
#include <algorithm>
#include <iostream>
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

bool isSorted( std::string & aWord ) {
   std::string compare( aWord ) ;
   std::sort( aWord.begin( ) , aWord.end( ) ) ;
   if (aWord == compare ) 
      return true ;
   else {
      std::reverse( aWord.begin( ) , aWord.end( ) ) ;
      if ( aWord == compare ) 
	 return true ;
      else 
	 return false ;
   }
}

int main( ) {
   std::cout << "Enter some words, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> words ( split( line , " " )) ;
   auto last = std::remove_if( words.begin( ) , words.end( ) ,
	    []( auto s ) { return isSorted( s ) ; } ) ;
   std::cout << static_cast<int>( std::distance( words.begin( ) , last) )
	 << std::endl ;
   return 0 ;
}
