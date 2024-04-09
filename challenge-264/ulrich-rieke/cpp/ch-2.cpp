#include <iostream>
#include <list>
#include <string>
#include <utility>
#include <vector>
#include <cstdlib>

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
   std::cout << "Enter some integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<int> numbers , indices ;
   std::vector<std::string> numberstrings { split( line , " " ) } ;
   for ( auto s : numberstrings )
      numbers.push_back( std::stoi( s ) ) ;
   std::cout << "Enter some indices into the number array!\n" ;
   std::getline( std::cin , line ) ;
   numberstrings.clear( ) ;
   numberstrings = split( line , " " ) ;
   for ( auto s : numberstrings )
      indices.push_back( std::stoi( s ) ) ;
   std::list<int> target ;
   std::vector<std::pair<int, int>> allPairs ;
   //the zip equivalent of other languages! form as many pairs as 
   //dictated by the smaller of 2 containers!
   int limit = std::min( numbers.size( ) , indices.size( ) ) ;
   for ( int i = 0 ; i < limit ; i++ ) 
      allPairs.push_back( std::make_pair( numbers[ i ] , indices[ i ] )) ;
   for ( auto it = allPairs.begin( ) ; it != allPairs.end( ) ; it++ ) {
      if ( target.size( ) == it->second ) {
	 target.push_back( it->first ) ;
      }
      else {
	 auto st = target.begin( ) ;
	 target.insert( std::next( st , it->second ) , 1 , it->first ) ;
      }
   }
   std::cout << "( " ;
   for ( int i : target ) 
      std::cout << i << ' ' ;
   std::cout << ")\n" ;
   return 0 ;
}
