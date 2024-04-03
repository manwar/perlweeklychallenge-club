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
   std::cout << "Enter some integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> numberstrings { split( line , " " ) } ;
   std::vector<int> numbers ;
   for ( auto s : numberstrings )
      numbers.push_back( std::stoi( s ) ) ;
   std::cout << "Enter a target integer!\n" ;
   std::getline( std::cin , line ) ;
   int k = std::stoi( line ) ;
   std::sort( numbers.begin( ) , numbers.end( ) ) ;
   std::vector<int> indices ;
   for ( int i = 0 ; i < numbers.size( ) ; i++ ) {
      if ( numbers[ i ] == k ) 
	 indices.push_back( i ) ;
   }
   std::cout << "( " ;
   for ( int i : indices )
      std::cout << i << ' ' ;
   std::cout << ")\n" ;
   return 0 ;
}
