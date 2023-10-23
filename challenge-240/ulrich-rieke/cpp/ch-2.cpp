#include <iostream>
#include <vector>
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
   std::cout << "Enter some positive integers, separated by blanks!\n" ;
   std::cout << "Numbers should be between 0 and array length - 1!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> numberstrings( split( line , " " ) ) ;
   std::vector<int> numbers ;
   for ( auto s : numberstrings ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::vector<int> newNumbers ;
   for ( int i = 0 ; i < numbers.size( ) ; i++ ) {
      int num = numbers[ i ] ;
      newNumbers.push_back( numbers[ num ] ) ;
   }
   std::cout << "( " ;
   for ( int i : newNumbers ) 
      std::cout << i << ' ' ;
   std::cout << ")\n" ;
   return 0 ;
}
