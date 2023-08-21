#include <iostream>
#include <string>
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

std::vector<int> decompose( int n ) {
   std::vector<int> digits ;
   while ( n != 0 ) {
      digits.push_back( n % 10 ) ;
      n /= 10 ;
   }
   std::reverse( digits.begin( ) , digits.end( ) ) ;
   return digits ;
}

int main( ) {
   std::cout << "Enter some positive integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<int> numbers ;
   std::vector<std::string> numberstrings ( split( line , " " ) ) ;
   for ( auto s : numberstrings ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::vector<int> allDigits ;
   for ( int i : numbers ) {
      std::vector<int> digits( decompose( i ) ) ;
      for ( int d : digits ) 
	 allDigits.push_back( d ) ;
   }
   std::cout << "( " ;
   for ( int d : allDigits ) {
      std::cout << d << ' ' ;
      if ( d != allDigits.back( ) ) 
	 std::cout << ", " ;
      else 
	 std::cout << " )\n" ;
   }
   return 0 ;
}


