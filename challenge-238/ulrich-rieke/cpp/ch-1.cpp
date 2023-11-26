#include <vector>
#include <string>
#include <iostream>

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
   std::vector<std::string> numberstrings( split( line , " " ) ) ;
   std::vector<int> numbers ;
   for ( auto s : numberstrings ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::vector<int> result ;
   int current_sum = 0 ;
   int size = numbers.size( ) ;
   for ( int i = 0 ; i < size ; i++ ) {
      current_sum += numbers[ i ] ;
      result.push_back( current_sum ) ;
   }
   std::cout << "( " ;
   for ( int i : result ) 
      std::cout << i << " " ;
   std::cout << ")\n" ;
   return 0 ;
}
