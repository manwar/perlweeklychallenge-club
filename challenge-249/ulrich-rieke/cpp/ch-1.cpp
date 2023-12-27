#include <vector>
#include <string>
#include <iostream>
#include <algorithm>
#include <utility>
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

int main( ) {
   std::cout << "Enter an even number of integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<int> numbers ;
   std::vector<std::string> numberstrings { split( line , " " ) } ;
   for ( auto s : numberstrings ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::map<int , int> frequencies ;
   for ( auto it = numbers.begin( ) ; it != numbers.end( ) ; ++it ) {
      frequencies[*it]++ ;
   }
   if ( std::all_of( frequencies.begin( ) , frequencies.end( ) , []( const 
	       auto & p ) { return p.second % 2 == 0 ; } ) ) {
      std::sort( numbers.begin( ) , numbers.end( ) ) ;
      std::vector<std::pair<int , int>> result ;
      int pos = 0 ;
      int len = numbers.size( ) ;
      while ( pos <= len - 2 ) {
	 std::pair<int, int> current { std::make_pair( numbers[ pos ] , 
	       numbers[ pos + 1 ] ) } ;
	 result.push_back( current ) ;
	 pos += 2 ;
      }
      std::cout << "(" ;
      for ( auto p : result ) {
	 std::cout << "[" << p.first << ',' << p.second << "]" ;
      }
      std::cout << ")\n" ;
   }
   else {
      std::cout << "()\n" ;
   }
   return 0 ;
}
