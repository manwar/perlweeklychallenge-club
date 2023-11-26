#include <vector>
#include <string>
#include <algorithm>
#include <iostream>
#include <numeric>

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

std::vector<int> decompose( int number ) {
   std::vector<int> digits ;
   while ( number != 0 ) {
      int remainder = number % 10 ;
      digits.push_back( remainder ) ;
      number /= 10 ;
   }
   return digits ;
}

int findSteps( int number ) {
   if ( number < 10 ) 
      return 0 ;
   else {
      int steps = 1 ;
      std::vector<int> digits ( decompose( number ) ) ;
      int product = std::accumulate( digits.begin( ) , digits.end( ) , 
	    1 , std::multiplies<int>( ) ) ;
      while ( product > 9 ) {
	 steps++ ;
	 digits = decompose( product ) ;
	 product = std::accumulate( digits.begin( ) , digits.end( ) , 
	       1 , std::multiplies<int>( ) ) ;
      }
      return steps ;
   }
}

bool mySorter( int a , int b ) {
   int steps1 = findSteps( a ) ;
   int steps2 = findSteps( b ) ;
   if ( steps1 != steps2 ) 
      return steps1 < steps2 ;
   else
      return a < b ;
}

int main( ) {
   std::cout << "Enter some positive integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> numberstrings( split( line , " " ) ) ;
   std::vector<int> numbers ;
   for ( auto s : numberstrings ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::sort( numbers.begin( ) , numbers.end( ) , []( int a , int b ) {
	 return mySorter( a , b ) ; } ) ;
   std::cout << "(" ;
   for ( int i : numbers ) {
      std::cout << i << " " ;
   }
   std::cout << ")\n" ;
   return 0 ;
}
