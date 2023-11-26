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

int myFlip( int num ) {
   if (num == 0 ) 
      return 1 ;
   else
      return 0 ;
}

int main( ) {
   std::cout << "Enter some 0 or 1 , separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::vector<int>> matrix ;
   std::vector<std::string> numberstrings( split( line , " " ) ) ;
   int len = numberstrings.size( ) ;
   std::vector<int> numbers ;
   for ( auto s : numberstrings )
      numbers.push_back( std::stoi( s ) ) ;
   matrix.push_back( numbers ) ;
   for ( int i = 0 ; i < len - 1 ; i++ ) {
      std::cout << "Please enter " << len << " numbers of 0 or 1 , " 
	 << "separated by blanks!\n" ;
      std::getline( std::cin , line ) ;
      numberstrings = split( line , " " ) ;
      numbers.clear( ) ;
      for ( auto s : numberstrings ) 
	 numbers.push_back( std::stoi( s ) ) ;
      matrix.push_back( numbers ) ;
   }
   std::transform( matrix.begin( ) , matrix.end( ) , matrix.begin( ) ,
	 []( auto & vec ) { std::reverse( vec.begin( ) , vec.end( ) ) ;
	 return vec ; } ) ;
   std::transform( matrix.begin( ) , matrix.end( ) , matrix.begin( ) ,
	 []( auto & vec ) { std::transform( vec.begin( ) , vec.end( ) , 
	    vec.begin( ) , myFlip ) ; return vec ; } ) ;
   std::cout << "(" ;
   for ( auto & vec : matrix ) {
      std::cout << "( " ;
      for ( int i : vec ) 
	 std::cout << i << " " ;
      std::cout << ")" ;
   }
   std::cout << ")\n" ;
   return 0 ;
}
