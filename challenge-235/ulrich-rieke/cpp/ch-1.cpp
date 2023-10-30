#include <vector>
#include <iostream>
#include <string>

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
   std::cout << "Enter some integers, separated by spaces!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> numberstrings( split( line , " " ) ) ;
   std::vector<int> numbers ;
   for ( auto s : numberstrings ) 
      numbers.push_back( std::stoi( s ) ) ;
   //if size is the length of numbers, we can form size - 1 neighbouring pairs
   //they all , bar one, must be strictly increasing
   int count = 0 ; //number of strictly increasing neighbouring pairs ;
   int pairnumber = numbers.size( ) - 1 ;
   for ( int pos = 0 ; pos < numbers.size( ) - 1 ; pos++ ) {
      if ( numbers[ pos + 1 ] > numbers[ pos ] ) 
	 count++ ;
   }
   if ( count == pairnumber - 1 ) 
      std::cout << "true\n" ;
   else
      std::cout << "false\n" ;
   return 0 ;
}
