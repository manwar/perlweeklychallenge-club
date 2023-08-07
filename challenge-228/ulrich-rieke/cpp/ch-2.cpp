#include <iostream>
#include <string>
#include <list>
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
   std::cout << "Enter some unique integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> numberstrings ( split ( line , " " ) ) ;
   std::list<int> numbers ;
   for ( auto s : numberstrings ) 
      numbers.push_back( std::stoi( s ) ) ;
   int rounds = 0 ;
   while ( numbers.size( ) > 0 ) {
      //look for the smallest element
      int mini = *std::min_element( numbers.begin( ) , numbers.end( ) ) ;
      auto pos = std::find( numbers.begin( ) , numbers.end( ) , mini ) ;
      if ( pos == numbers.begin( ) ) //if the smallest element is at the start
	 //of list numbers
	 numbers.remove( mini ) ;  //remove it
      else {
	 int first = *numbers.begin( ) ; //save the first element
	 numbers.pop_front( ) ;
	 numbers.push_back( first ) ; //and push it at the end of the vector
      }
      rounds++ ;
   }
   std::cout << rounds << std::endl ;
   return 0 ;
}
