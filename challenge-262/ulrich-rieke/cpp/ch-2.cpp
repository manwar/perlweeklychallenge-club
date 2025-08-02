#include <iostream>
#include <vector>
#include <string>
#include <utility>
#include <numeric>

std::vector<std::pair<int, int>> findCombinations( const std::vector<int> &
      positions ) {
   std::vector<std::pair<int , int>> allCombis ;
   int len = positions.size( ) ;
   for ( int pos = 0 ; pos < len - 1 ; pos++ ) {
      for ( int end = pos + 1 ; end < len ; end++ ) {
	 allCombis.push_back( std::make_pair( pos , end ) ) ;
      }
   }
   return allCombis ;
}

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
   std::vector<std::string> numberterms ( split( line , " " ) ) ;
   std::vector<int> numbers ;
   for ( auto s : numberterms ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::cout << "Enter another integer!\n" ;
   int k ;
   std::cin >> k ;
   std::vector<int> indices( numbers.size( ) ) ;
   std::iota( indices.begin( ) , indices.end( ) , 0 ) ;
   int sum = 0 ;
   std::vector<std::pair<int , int>> allPairs { findCombinations( indices ) } ;
   for ( auto p : allPairs ) {
      if ( numbers[ p.first ] == numbers[ p.second] && ( (p.first * 
		  p.second ) % k == 0 ) ) 
	 sum++ ;
   }
   std::cout << sum << '\n' ;
   return 0 ;
}
