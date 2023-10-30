#include <vector>
#include <iostream>
#include <algorithm>
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
   std::cout << "Enter some integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> numberstrings( split( line , " " ) ) ;
   std::vector<int> numbers ;
   for ( auto s : numberstrings ) //convert to vector of ints 
      numbers.push_back( std::stoi( s ) ) ;
   int len = numbers.size( ) ;
   //if we want to create successive permutations, we have to sort
   //the vector of numbers we entered. Subsequently, we create 
   //permutations on it. To have something to compare to we have to
   //create a copy of the numbers
   std::vector<int> original_numbers( numbers ) ;
   int max_greatness = 0 ;
   std::sort( numbers.begin( ) , numbers.end( ) ) ;
   while ( std::next_permutation( numbers.begin( ) , numbers.end( ) ) ) {
      int current_greatness = 0 ;
      for ( int i = 0 ; i < len ; i++ ) {
	 if ( numbers[ i ] > original_numbers[ i ] ) {
	    current_greatness++ ;
	 }
      }
      if ( current_greatness > max_greatness ) 
	 max_greatness = current_greatness ;
   }
   std::cout << max_greatness << std::endl ;
   return 0 ;
}
