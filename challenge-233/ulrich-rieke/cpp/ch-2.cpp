#include <iostream>
#include <string>
#include <algorithm>
#include <utility>
#include <vector>
#include <map> 

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

bool compare( const std::pair<int, int> & a , const std::pair<int , int>
      & b ) {
   if ( a.second != b.second ) {
      return a.second < b.second ;
   }
   else {
      return a.first > b.first ;
   }
}

int main( ) {
   std::cout << "Please enter some integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> numberstrings( split( line, " " ) ) ;
   std::vector<int> numbers ;
   for ( auto s : numberstrings ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::map<int , int> frequencies ;
   for ( int i : numbers ) {
      if ( frequencies.find( i ) == frequencies.end( ) ) {
	 frequencies[ i ] = std::count( numbers.begin( ) , numbers.end( ) , 
	       i ) ;
      }
   }
   std::vector<std::pair<int, int>> allPairs( frequencies.begin( ) , 
	 frequencies.end( ) ) ;
   std::sort( allPairs.begin( ) , allPairs.end( ) , compare ) ;
   std::vector<int> result ;
   for ( auto p : allPairs ) {
      for ( int i = 0 ; i < p.second ; i++ ) {
	 result.push_back( p.first ) ;
      }
   }
   std::cout << "(" ;
   int count = 0 ;
   int size = result.size( ) ;
   for ( int i : result ) {
      std::cout << i ;
      count++ ;
      if ( count < size ) {
	 std::cout << " , " ;
      }
      else {
	 std::cout << ")\n" ;
      }
   }
   return 0 ;
}
