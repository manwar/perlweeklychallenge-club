#include <iostream>
#include <string>
#include <vector>
#include <utility>
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
   std::cout << "Enter a string!\n" ;
   std::string str ;
   std::getline( std::cin , str ) ;
   std::cout << "Enter indices into the string!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> numberstrings( split( line, " " ) ) ;
   std::vector<int> numbers ;
   for ( auto s : numberstrings ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::vector<std::pair<int, char>> allPairs ;
   for ( int i = 0 ; i < numberstrings.size( ) ; i++ ) {
      allPairs.push_back( std::make_pair( numbers[ i ] , str[ i ] ) ) ;
   }
   std::sort( allPairs.begin( ) , allPairs.end( ) , []( const auto & p1 , 
	    const auto &  p2 ) { return p1.first < p2.first ; } ) ;
   std::string solution ;
   for ( const auto p : allPairs ) 
      solution += p.second ;
   std::cout << solution << std::endl ;
   return 0 ;
}

